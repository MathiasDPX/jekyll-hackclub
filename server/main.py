from slack_sdk import WebClient
from dotenv import load_dotenv
from flask import Flask, abort
import os

load_dotenv()
app = Flask(__name__)
client = WebClient(os.environ.get("SLACK_BOT_TOKEN"))

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

if __name__ == "__main__":
    app.run()