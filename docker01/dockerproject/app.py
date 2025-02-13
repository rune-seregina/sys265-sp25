from flask import Flask
import redis

app = Flask(__name__)
redis_client = redis.Redis(host='redis', port=6379)

@app.route('/')
def hello():
    visit_count = redis_client.incr('visits')
    html = f"""
    <!DOCTYPE html>
    <html>
    <head>
        <title>Docker Visitor Counter</title>
    </head>
    <body style="background-color:#f0f0f0; text-align:center; padding-top:50px;">
        <h1 style="color:#333;">Hello, Docker!</h1>
        <p style="font-size:1.2em;">This page has been viewed <strong>{visit_count}</strong> times.</p>
    </body>
    </html>
    """
    return html

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0')
