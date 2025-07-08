from flask import Flask, abort, redirect, jsonify
from slack_sdk.errors import *
from slack_sdk import WebClient
from dotenv import load_dotenv
from flask_cors import CORS
import os
from cache_manager import Cache

load_dotenv()
app = Flask(__name__)
CORS(app)
client = WebClient(os.environ.get("SLACK_BOT_TOKEN"))

cache = Cache(ttl=int(os.getenv("CACHE_TTL", 3600)))
emojis = client.emoji_list().data.get("emoji", {})
usergroups = {}

for usergroup in client.usergroups_list().data.get("usergroups", []):
    usergroups[usergroup["id"]] = usergroup

@app.errorhandler(Exception)
def handle_error(e:Exception):
    if isinstance(e, SlackClientError):
        if isinstance(e, SlackApiError):
            response = e.response
            return response.data, response.status_code
        
    return {"ok": False, "error": "unknown error"}, 500

@app.route("/", methods=["GET"])
def index():
    return redirect("https://github.com/MathiasDPX/jekyll-hackclub/")

@app.route("/status", methods=["GET"])
def status():
    return "ok", 200

@app.route("/users.info/<uid>", methods=["GET"])
def users_page(uid: str):
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
    eid = eid.strip(":")
    return emojis.get(
        eid,
        "https://emoji.slack-edge.com/T0266FRGM/alibaba-question/c5ba32ce553206b8.png"
    )

@app.route("/usergroup/<gid>", methods=["GET"])
def usergroup_page(gid: str):
    return usergroups.get(gid, {})

if __name__ == "__main__":
    app.run()