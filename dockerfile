# Multi-arch Python + Java 24
# Start from official OpenJDK 24 image (multi-arch)
FROM ghcr.io/adoptium/temurin:24-jdk-focal

# Install Python 3.13
RUN apt-get update && apt-get install -y python3.13 python3.13-venv python3.13-dev python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Set Python3 as default
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.13 1

# Verify
RUN python3 --version && java -version

# Default command
CMD ["bash"]
