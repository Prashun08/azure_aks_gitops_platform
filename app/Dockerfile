FROM python:3.10-slim AS base

WORKDIR /app

# Prevent python from writing pyc files
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install dependencies first (better caching)
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Copy only required files
COPY app.py .

EXPOSE 5000

CMD ["python", "app.py"]
