# Dockerfile

# Use the official Python image as a base
FROM python:3.12-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1  # Ensures logs are output immediately
ENV PYTHONDONTWRITEBYTECODE=1  # Prevents Python from writing .pyc files

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt /app/

# Install dependencies
RUN pip install --upgrade pip \
    && pip install -r requirements.txt \
    && pip install gunicorn  # Install Gunicorn for production

# Copy the current directory contents into the container at /app
COPY . /app/

# Expose port 8000 (default for Gunicorn)
EXPOSE 8000

# Start Gunicorn with 3 worker processes
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "3", "myproject.wsgi:application"]
