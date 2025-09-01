# Start from an official Linux base image
FROM ubuntu:24.04

# Set non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies for both Python and Java
RUN apt-get update && \
    apt-get install -y \
    wget \
    curl \
    build-essential \
    software-properties-common \
    ca-certificates \
    git \
    unzip \
    zip \
    && rm -rf /var/lib/apt/lists/*

# ------------------------
# Install Python 3.13
# ------------------------
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.13 python3.13-venv python3.13-dev python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Set python3 to point to python3.13
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.13 1

# ------------------------
# Install Java 24 (EA)
# ------------------------
RUN wget https://download.java.net/java/early_access/jdk24/latest/binaries/openjdk-24_linux-x64_bin.tar.gz -O /tmp/jdk24.tar.gz && \
    mkdir -p /opt/jdk24 && \
    tar -xzf /tmp/jdk24.tar.gz -C /opt/jdk24 --strip-components=1 && \
    rm /tmp/jdk24.tar.gz

# Set JAVA_HOME and update PATH
ENV JAVA_HOME=/opt/jdk24
ENV PATH="$JAVA_HOME/bin:$PATH"

# Verify installations
RUN java -version
RUN python3 --version
RUN pip3 --version

# Set working directory
WORKDIR /app

# Default command
CMD [ "bash" ]
