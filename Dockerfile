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
