# Use the official Python image from the Docker Hub
FROM python:3.12-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file to the container
COPY ./requirements.txt /app/requirements.txt

# Install the required dependencies
RUN pip install --no-cache-dir -r /app/requirements.txt

# Copy the Django project code into the container
COPY . /app

# Expose the port that Django will run on (matches the docker-compose.yml)
EXPOSE 5001

# Run database migrations and collect static files (adjust if needed)
RUN python manage.py migrate
#RUN python manage.py collectstatic --noinput

# Define the default command to run your application with Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:5001", "--workers", "3", "django_app_01.wsgi:application"]