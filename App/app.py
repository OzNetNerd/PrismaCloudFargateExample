from flask import Flask
import os

FLASK_PORT = int(os.environ.get("FLASK_PORT", 8080))

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello! I am a Fargate Task!"

if __name__ == "__main__":
    app.run(debug=True,host='0.0.0.0',port=FLASK_PORT)