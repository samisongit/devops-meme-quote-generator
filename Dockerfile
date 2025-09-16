# --- Build Stage ---
# Use an official Python runtime as a build base image
FROM python:3.9-slim as builder

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements.txt file (if you have one, we'll create it next)
# COPY requirements.txt .

# Install build dependencies (if needed for specific packages)
# For a simple Flask app, this might not be strictly necessary in the builder,
# but it's good practice if you have compiled dependencies later.
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     build-essential \
#     && rm -rf /var/lib/apt/lists/*

# Install Python dependencies into a temporary directory
# We'll assume you'll create a requirements.txt file shortly.
# RUN pip install --user -r requirements.txt


# --- Runtime Stage ---
# Use a smaller, final base image for the runtime
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy only the necessary files from the build stage (or local directory)
# For now, we'll copy the application code directly.
# (If you had compiled assets in the builder stage, you'd copy them here)
COPY . .

# Install *only* the runtime dependencies needed for the final image
# Create a requirements.txt file first (see next step).
RUN pip install -r requirements.txt

# Make port 5000 available to the world outside this container
# (Flask's default port)
EXPOSE 5000

# Define environment variable (optional, can be overridden)
ENV FLASK_APP=app.py

# Run the application when the container launches
# Use python -u for unbuffered output, useful for logging in containers
CMD ["python", "-u", "app.py"]