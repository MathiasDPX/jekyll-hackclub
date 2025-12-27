"""
Main entrypoint for the Slack bridge
"""

import os
import requests
from flask import Flask, redirect, jsonify, abort, Response
from slack_sdk.errors import SlackClientError, SlackApiError
from slack_sdk import WebClient
from dotenv import load_dotenv
from flask_cors import CORS
from cache_manager import Cache

load_dotenv()
app = Flask(__name__)
CORS(app)
client = WebClient(os.environ.get("SLACK_BOT_TOKEN"))

cache = Cache(ttl=int(os.getenv("CACHE_TTL", "3600")))


def get_emojis():
    """
    Get the list of emojis from Slack API with caching
    """
    key = "emojis"
    data = cache.get(key)
    if data is not None:
        return data

    data = client.emoji_list().data.get("emoji", {})
    cache.set(key, data, ttl=7200)  # 2 hours
    return data


usergroups = {}

for usergroup in client.usergroups_list().data.get("usergroups", []):
    usergroups[usergroup["id"]] = usergroup


@app.errorhandler(Exception)
def handle_error(e: Exception):
    """
    Common error handler for all routes
    """

    if isinstance(e, SlackClientError):
        if isinstance(e, SlackApiError):
            response = e.response
            return response.data, response.status_code

    return {"ok": False, "error": "unknown error"}, 500


@app.route("/", methods=["GET"])
def index():
    """
    Redirect to the repository
    """
    return redirect("https://github.com/MathiasDPX/jekyll-hackclub/")


@app.route("/status", methods=["GET"])
def status():
    """
    Health check endpoint
    """
    return "ok", 200


@app.route("/users.info/<uid>", methods=["GET"])
def users_page(uid: str):
    """
    Get user information from Slack API with caching

    Args:
        uid (str): Slack user ID

    Returns:
        (dict) User information
    """
    key = f"users.info#{uid}"
    data = cache.get(key)

    if data is not None:
        if isinstance(data, Exception):
            raise data
        return jsonify(data)

    response = client.users_info(user=uid).data
    cache.set(key, response)
    return jsonify(response)


@app.route("/files.info/<fid>", methods=["GET"])
def files_page(fid: str):
    """
    Get file information from Slack API with caching

    Args:
        fid (str): Slack file ID

    Returns:
        (dict) File information
    """
    key = f"files.info#{fid}"
    data = cache.get(key)

    if data is not None:
        if isinstance(data, Exception):
            raise data
        return jsonify(data)

    response = client.files_info(file=fid).data
    cache.set(key, response)
    return jsonify(response)


@app.route("/conversations.info/<cid>", methods=["GET"])
def channels_page(cid: str):
    """
    Get conversation/channel information from Slack API with caching

    Args:
        cid (str): Slack conversation/channel ID

    Returns:
        (dict) Conversation information
    """
    key = f"conversations.info#{cid}"
    data = cache.get(key)

    if data is not None:
        if isinstance(data, Exception):
            raise data
        return jsonify(data)

    response = client.conversations_info(channel=cid).data
    cache.set(key, response)
    return jsonify(response)


@app.route("/emoji/<eid>", methods=["GET"])
def emoji_page(eid: str):
    """
    Get emoji URL from Slack workspace

    Args:
        eid (str): Emoji name/ID (with or without colons)

    Returns:
        (str) URL of the emoji or default question mark emoji
    """
    eid = eid.strip(":")
    url = get_emojis().get(eid) or get_emojis().get("alibaba-question")

    req = requests.get(url, timeout=5)
    contenttype = req.headers.get("content-type")

    if not contenttype.startswith("image/"):
        return abort(404)

    return Response(req.content, mimetype=contenttype)


@app.route("/usergroup/<gid>", methods=["GET"])
def usergroup_page(gid: str):
    """
    Get usergroup information from cached Slack API data

    Args:
        gid (str): Slack usergroup ID

    Returns:
        (dict) usergroup information or empty dict if not found
    """
    return usergroups.get(gid, {})


if __name__ == "__main__":
    app.run()
