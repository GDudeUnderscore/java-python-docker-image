# Use Python 3.12 slim image (ARM64 compatible)
FROM python:3.12-slim

# Install Java 22 (Temurin) using apt repo or prebuilt tar.gz
RUN apt-get update && apt-get install -y --no-install-recommends \
        wget \
        ca-certificates \
        unzip \
        git \
        && rm -rf /var/lib/apt/lists/* && \
    mkdir -p /usr/lib/jvm && \
    wget -O /tmp/temurin22.tar.gz https://github.com/adoptium/temurin22-binaries/releases/download/jdk-22.0.2+9/OpenJDK22U-jdk_aarch64_linux_hotspot.tar.gz && \
    tar -xzf /tmp/temurin22.tar.gz -C /usr/lib/jvm && \
    rm /tmp/temurin22.tar.gz && \
    update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-22*/bin/java 1 && \
    update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk-22*/bin/javac 1

# Set working directory
WORKDIR /srv/daemon-data

# Set default shell
SHELL ["/bin/bash", "-c"]

CMD ["bash"]
