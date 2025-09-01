# Multi-arch Python 3.13 + Java 21
FROM --platform=$BUILDPLATFORM ghcr.io/adoptium/temurin:21-jdk-bullseye

# Install Python 3.13 and pip
RUN apt-get update && apt-get install -y --no-install-recommends \
        python3.13 \
        python3.13-venv \
        python3.13-dev \
        python3-pip \
        build-essential \
        wget \
        curl \
        unzip \
    && rm -rf /var/lib/apt/lists/*

# Verify installations
RUN python3 --version && java -version

# Working directory and copy
WORKDIR /app
COPY . /app

# Install Python dependencies
RUN if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi

# Default command
CMD ["python3", "hapily.py"]
