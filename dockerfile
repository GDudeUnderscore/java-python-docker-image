# Use the official Python 3.13.7 image based on Debian Bullseye
FROM python:3.13.7-slim-bullseye

# Install OpenJDK 24 (Adoptium)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    openjdk-24-jdk \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set environment variables for Java and Python
ENV JAVA_HOME=/usr/lib/jvm/java-24-openjdk-amd64
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Optionally, set the working directory
WORKDIR /app

# Copy your application code into the container
COPY . /app

# Install any required Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Command to run your application
CMD ["python", "your_script.py"]
