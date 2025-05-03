from flask import Flask, abort, redirect
from slack_sdk import WebClient
from dotenv import load_dotenv
import os

load_dotenv()
app = Flask(__name__)
client = WebClient(os.environ.get("SLACK_BOT_TOKEN"))

emojis = client.emoji_list().data.get("emoji", {})

@app.route("/", methods=["GET"])
def index():
    return redirect("https://github.com/MathiasDPX/jekyll-hackclub/")

@app.route("/users.info/<uid>", methods=["GET"])
def users_page(uid:str):
    try:
        req = client.users_info(user=uid)
    except:
        abort(500)
        return
    
    return req.data

@app.route("/conversations.info/<cid>", methods=["GET"])
def channels_page(cid:str):
    try:
        req = client.conversations_info(channel=cid)
    except:
        abort(500)
        return

    return req.data

@app.route("/emoji/<eid>", methods=["GET"])
def emoji_page(eid:str):
    eid = eid.strip(":")
    return emojis.get(eid, "https://emoji.slack-edge.com/T0266FRGM/alibaba-question/c5ba32ce553206b8.png")

if __name__ == "__main__":
    app.run()