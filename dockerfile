# Use Ubuntu 24.04 as base
FROM ubuntu:24.04

# Set non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies for Python build and basic tools
RUN apt-get update && apt-get install -y \
    wget curl build-essential software-properties-common \
    libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
    libffi-dev libncursesw5-dev xz-utils tk-dev liblzma-dev git \
    && rm -rf /var/lib/apt/lists/*

# ------------------------
# Install Python 3.13 from source
# ------------------------
RUN wget https://www.python.org/ftp/python/3.13.7/Python-3.13.7.tgz && \
    tar xzf Python-3.13.7.tgz && \
    cd Python-3.13.7 && \
    ./configure --enable-optimizations --with-ensurepip=install && \
    make -j$(nproc) && make altinstall && \
    cd .. && rm -rf Python-3.13.7 Python-3.13.7.tgz

# Make python3 point to python3.13
RUN update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.13 1

# Upgrade pip
RUN python3 -m pip install --upgrade pip

# ------------------------
# Install Java 24
# ------------------------
RUN wget https://download.java.net/java/early_access/jdk24/24/GPL/openjdk-24_linux-x64_bin.tar.gz -O /tmp/jdk24.tar.gz && \
    mkdir -p /opt/jdk24 && \
    tar -xzf /tmp/jdk24.tar.gz -C /opt/jdk24 --strip-components=1 && \
    rm /tmp/jdk24.tar.gz

# Set Java environment
ENV JAVA_HOME=/opt/jdk24
ENV PATH="$JAVA_HOME/bin:$PATH"

# Set working directory
WORKDIR /app

# Default command
CMD ["bash"]
