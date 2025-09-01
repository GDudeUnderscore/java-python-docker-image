# Use official Python 3.13 slim image (multi-arch: amd64 + arm64)
FROM python:3.13-slim

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install Java 24 dependencies
RUN apt-get update && apt-get install -y wget unzip ca-certificates build-essential && rm -rf /var/lib/apt/lists/*

# Download and install OpenJDK 24
RUN wget https://download.java.net/java/GA/jdk24/1f9ff9062db4449d8ca828c504ffae90/36/GPL/openjdk-24_linux-x64_bin.tar.gz -O /tmp/jdk24.tar.gz \
    && mkdir -p /usr/lib/jvm \
    && tar -xzf /tmp/jdk24.tar.gz -C /usr/lib/jvm \
    && rm /tmp/jdk24.tar.gz

# Set JAVA_HOME and update PATH
ENV JAVA_HOME=/usr/lib/jvm/jdk-24
ENV PATH="$JAVA_HOME/bin:$PATH"

# Verify installations
RUN python3 --version && java -version

# Default command
CMD ["bash"]
