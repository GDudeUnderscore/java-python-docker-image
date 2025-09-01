# Multi-arch Python 3.13 + Java 21 (Temurin)
FROM --platform=$BUILDPLATFORM python:3.13-slim-bullseye

# Prevent interactive prompts during package installs
ENV DEBIAN_FRONTEND=noninteractive
ENV JAVA_HOME=/usr/lib/jvm/jdk-21

# Install required packages
RUN apt-get update && apt-get install -y --no-install-recommends \
        wget \
        curl \
        unzip \
        gnupg \
        software-properties-common \
        build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install JDK 21 (Temurin) for target architecture
RUN wget https://github.com/adoptium/temurin21-binaries/releases/latest/download/OpenJDK21U-jdk_${TARGETARCH}_linux_hotspot.tar.gz -O /tmp/jdk.tar.gz \
    && mkdir -p /usr/lib/jvm \
    && tar -xzf /tmp/jdk.tar.gz -C /usr/lib/jvm \
    && rm /tmp/jdk.tar.gz \
    && update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-21/bin/java 1 \
    && update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk-21/bin/javac 1

# Optional: For ARM64, ensure Python packages are available
RUN if [ "$(dpkg --print-architecture)" = "arm64" ]; then \
        apt-get update && apt-get install -y --no-install-recommends \
        python3.13 python3.13-venv python3.13-dev python3-pip \
        && rm -rf /var/lib/apt/lists/*; \
    fi

# Verify installations
RUN python3 --version && java -version

# Set working directory and copy app files
WORKDIR /app
COPY . /app

# Install Python dependencies if requirements.txt exists
RUN if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi

# Default command
CMD ["python3", "hapily.py"]
