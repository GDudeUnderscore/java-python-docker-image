# Multi-arch Python 3.13 + Java (JDK 21)
# Base image: Python 3.13 slim (multi-arch)
FROM python:3.13-slim

# Install required packages
RUN apt-get update && apt-get install -y \
        software-properties-common \
        wget \
        unzip \
        curl \
        gnupg \
        build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install JDK 21 (Temurin, multi-arch)
RUN wget https://github.com/adoptium/temurin21-binaries/releases/latest/download/OpenJDK21U-jdk_${TARGETARCH}_linux_hotspot.tar.gz -O /tmp/jdk.tar.gz \
    && mkdir -p /usr/lib/jvm \
    && tar -xzf /tmp/jdk.tar.gz -C /usr/lib/jvm \
    && rm /tmp/jdk.tar.gz \
    && update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-21/bin/java 1 \
    && update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk-21/bin/javac 1

# Optional: Add deadsnakes PPA for ARM64 if Python packages needed
RUN if [ "$(dpkg --print-architecture)" = "arm64" ]; then \
        apt-get update && apt-get install -y software-properties-common && \
        add-apt-repository ppa:deadsnakes/ppa && \
        apt-get update && apt-get install -y python3.13 python3.13-venv python3.13-dev python3-pip && \
        rm -rf /var/lib/apt/lists/*; \
    fi

# Verify installations
RUN python3 --version && java -version

# Set working directory
WORKDIR /app
COPY . /app

# Install Python dependencies if requirements.txt exists
RUN if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi

CMD ["python3", "hapily.py"]
