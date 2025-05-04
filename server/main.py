from flask import Flask, abort, redirect, jsonify
from slack_sdk import WebClient
from dotenv import load_dotenv
import os
from cache_manager import Cache

load_dotenv()
app = Flask(__name__)
client = WebClient(os.environ.get("SLACK_BOT_TOKEN"))

cache = Cache(ttl=int(os.getenv("CACHE_TTL", 3600)))
emojis = client.emoji_list().data.get("emoji", {})

@app.route("/", methods=["GET"])
def index():
    return redirect("https://github.com/MathiasDPX/jekyll-hackclub/")

@app.route("/users.info/<uid>", methods=["GET"])
def users_page(uid: str):
    key = f"users.info#{uid}"
    data = cache.get(key)

    if data is not None:
        if isinstance(data, int):
            abort(data)
        return jsonify(data)

    try:
        response = client.users_info(user=uid).data
    except Exception:
        cache.set(key, 500)
        abort(500)
    else:
        cache.set(key, response)
        return jsonify(response)

@app.route("/files.info/<fid>", methods=["GET"])
def files_page(fid: str):
    key = f"files.info#{fid}"
    data = cache.get(key)

    if data is not None:
        if isinstance(data, int):
            abort(data)
        return jsonify(data)
    
    try:
        response = client.files_info(file=fid).data
    except Exception:
        cache.set(key, 500)
        abort(500)
    else:
        cache.set(key, response)
        return jsonify(response)

@app.route("/conversations.info/<cid>", methods=["GET"])
def channels_page(cid: str):
    key = f"conversations.info#{cid}"
    data = cache.get(key)

    if data is not None:
        if isinstance(data, int):
            abort(data)
        return jsonify(data)
    
    try:
        response = client.conversations_info(channel=cid).data
    except Exception:
        cache.set(key, 500)
        abort(500)
    else:
        cache.set(key, response)
        return jsonify(response)

@app.route("/emoji/<eid>", methods=["GET"])
def emoji_page(eid: str):
    eid = eid.strip(":")
    return emojis.get(
        eid,
        "https://emoji.slack-edge.com/T0266FRGM/alibaba-question/c5ba32ce553206b8.png"
    )

if __name__ == "__main__":
    app.run()