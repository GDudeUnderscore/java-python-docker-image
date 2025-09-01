FROM ubuntu:24.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget curl software-properties-common build-essential \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update \
    && apt-get install -y python3.13 python3.13-venv python3.13-dev python3-pip \
    && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.13 1 \
    && rm -rf /var/lib/apt/lists/*

# Install Java 24 (manually)
RUN wget https://download.java.net/java/early_access/jdk24/latest/binaries/openjdk-24_linux-x64_bin.tar.gz -O /tmp/jdk24.tar.gz && \
    mkdir -p /opt/jdk24 && \
    tar -xzf /tmp/jdk24.tar.gz -C /opt/jdk24 --strip-components=1 && \
    rm /tmp/jdk24.tar.gz

ENV JAVA_HOME=/opt/jdk24
ENV PATH="$JAVA_HOME/bin:$PATH"

WORKDIR /app
CMD ["bash"]
