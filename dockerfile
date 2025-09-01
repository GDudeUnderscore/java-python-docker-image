# -----------------------------
# Optimized Python 3.12 + Java 21 ARM64 Dockerfile
# -----------------------------

# Base image: Python 3.12 slim (ARM64)
FROM python:3.12-slim

# Set noninteractive for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install minimal dependencies for Java and Pterodactyl
RUN apt-get update && apt-get install -y --no-install-recommends \
        wget \
        ca-certificates \
        unzip \
        git \
        curl \
    && rm -rf /var/lib/apt/lists/*

# Install Java 21 (Temurin, ARM64)
RUN mkdir -p /usr/lib/jvm && \
    wget -O /tmp/temurin21.tar.gz https://github.com/adoptium/temurin21-binaries/releases/latest/download/OpenJDK21U-jdk_aarch64_linux_hotspot.tar.gz && \
    tar -xzf /tmp/temurin21.tar.gz -C /usr/lib/jvm && \
    rm /tmp/temurin21.tar.gz && \
    update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-21*/bin/java 1 && \
    update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk-21*/bin/javac 1

# Verify Python and Java installations
RUN python3 --version && java -version

# Set working directory for Pterodactyl
WORKDIR /srv/daemon-data

# Default shell
SHELL ["/bin/bash", "-c"]

# Default command
CMD ["bash"]
