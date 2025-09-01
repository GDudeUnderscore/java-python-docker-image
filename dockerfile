# Use Python 3.11 slim-bullseye (ARM64)
FROM arm64v8/python:3.11-slim-bullseye

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget curl bash ca-certificates libssl-dev zlib1g-dev \
    libncurses5-dev libreadline-dev libsqlite3-dev libffi-dev libbz2-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install OpenJDK 24 (Adoptium prebuilt ARM64)
RUN wget https://github.com/adoptium/temurin24-binaries/releases/latest/download/OpenJDK24U-jdk_aarch64_linux_hotspot.tar.gz \
    && tar -xzf OpenJDK24U-jdk_aarch64_linux_hotspot.tar.gz -C /usr/lib/jvm \
    && rm OpenJDK24U-jdk_aarch64_linux_hotspot.tar.gz

# Set Java environment
ENV JAVA_HOME=/usr/lib/jvm/jdk-24
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Create Pterodactyl user
RUN useradd -m -s /bin/bash container
USER container
WORKDIR /home/container

# Default command
CMD ["/bin/bash"]
