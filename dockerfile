# Use Ubuntu 22.04 ARM64 base
FROM arm64v8/ubuntu:22.04

# Set environment variables for Java
ENV JAVA_HOME=/usr/lib/jvm/jdk-24
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies, Python 3.13, and bash/curl/wget
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3.13 python3.13-venv python3.13-distutils \
    curl wget bash ca-certificates \
    libssl-dev zlib1g-dev libncurses5-dev libreadline-dev libsqlite3-dev libffi-dev libbz2-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install OpenJDK 24 (Adoptium Temurin ARM64)
RUN wget https://github.com/adoptium/temurin24-binaries/releases/latest/download/OpenJDK24U-jdk_aarch64_linux_hotspot.tar.gz \
    && tar -xzf OpenJDK24U-jdk_aarch64_linux_hotspot.tar.gz -C /usr/lib/jvm \
    && rm OpenJDK24U-jdk_aarch64_linux_hotspot.tar.gz

# Create Pterodactyl-compatible user
RUN useradd -m -s /bin/bash container
USER container
WORKDIR /home/container

# Default command
CMD ["/bin/bash"]
