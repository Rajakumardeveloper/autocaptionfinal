FROM python:3.11-slim
RUN apt-get update && apt-get install -y ffmpeg fontconfig && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
RUN mkdir -p /usr/share/fonts/truetype/custom && cp fonts/*.ttf /usr/share/fonts/truetype/custom/ && fc-cache -f -v
CMD ["sh", "-c", "uvicorn app:app --host 0.0.0.0 --port ${PORT:-8000}"]
