from flask import Flask
 
app = Flask(__name__)
 
@app.route('/')
def hello():
   return "Hello, Docker!"
 
if __name__ == "__main__":
   app.run(debug=True, host='0.0.0.0')
```
<br></br>
* `vi requirements.txt`
<br></br>
```
Flask==2.3.2
```
<br></br>
* `vi Dockerfile`
<br></br>
```
FROM python:3.9-slim

WORKDIR /app
COPY app.py /app/app.py

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

COPY . /.

CMD ["python", "app.py"]

EXPOSE 5000
