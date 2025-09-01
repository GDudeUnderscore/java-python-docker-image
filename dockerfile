# Base image
FROM ubuntu:22.04

# Set noninteractive for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        curl \
        gnupg \
        lsb-release \
        software-properties-common \
        unzip \
        git \
        ca-certificates \
        && rm -rf /var/lib/apt/lists/*

# Install Python 3.12 (prebuilt)
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.12 python3.12-venv python3.12-distutils python3-pip && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12 1 && \
    rm -rf /var/lib/apt/lists/*

# Install Java 22 (Eclipse Temurin)
RUN mkdir -p /usr/lib/jvm && \
    wget -O /tmp/temurin22.tar.gz https://github.com/adoptium/temurin22-binaries/releases/latest/download/OpenJDK22U-jdk_aarch64_linux_hotspot.tar.gz && \
    tar -xzf /tmp/temurin22.tar.gz -C /usr/lib/jvm && \
    rm /tmp/temurin22.tar.gz && \
    update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-22*/bin/java 1 && \
    update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk-22*/bin/javac 1

# Set working directory
WORKDIR /srv/daemon-data

# Set default shell
SHELL ["/bin/bash", "-c"]

# Expose standard Pterodactyl ports if needed
# EXPOSE 25565

# Default command
CMD ["bash"]
