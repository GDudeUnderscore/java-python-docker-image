# Use a lightweight Ubuntu base
FROM ubuntu:24.04

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update packages and install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    software-properties-common \
    build-essential \
    unzip \
    git \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Python 3.13
RUN add-apt-repository ppa:deadsnakes/ppa -y \
    && apt-get update \
    && apt-get install -y python3.13 python3.13-dev python3.13-venv python3-pip \
    && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.13 1

# Install Java 24 (OpenJDK)
RUN apt-get update && apt-get install -y wget unzip \
    && wget https://download.java.net/java/GA/jdk24/1f9ff9062db4449d8ca828c504ffae90/36/GPL/openjdk-24_linux-x64_bin.tar.gz -O /tmp/jdk24.tar.gz \
    && mkdir -p /usr/lib/jvm \
    && tar -xzf /tmp/jdk24.tar.gz -C /usr/lib/jvm \
    && rm /tmp/jdk24.tar.gz

# Set JAVA_HOME and add Java to PATH
ENV JAVA_HOME=/usr/lib/jvm/jdk-24
ENV PATH="$JAVA_HOME/bin:$PATH"

# Verify installations
RUN python3 --version && java -version

# Default command
CMD ["bash"]
