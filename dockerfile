# Use Python 3.11 slim-bullseye as base (ARM64 compatible)
FROM arm64v8/python:3.11-slim-bullseye

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies and OpenJDK 24
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    curl \
    bash \
    ca-certificates \
    libssl-dev \
    zlib1g-dev \
    libncurses5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libffi-dev \
    libbz2-dev \
    openjdk-24-jdk \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set environment variables for Java
ENV JAVA_HOME=/usr/lib/jvm/java-24-openjdk-arm64
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Create Pterodactyl user
RUN useradd -m -s /bin/bash container
USER container
WORKDIR /home/container

# Default command
CMD ["/bin/bash"]
