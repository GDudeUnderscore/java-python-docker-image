# -----------------------------
# Python 3.12 + Java 21 ARM64 Dockerfile
# Optimized for Pterodactyl
# -----------------------------

# Base image: Eclipse Temurin 21 JDK (ARM64, prebuilt)
FROM eclipse-temurin:21-jdk-jammy

# Set noninteractive for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install Python 3.12 only (prebuilt), minimal dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        python3.12 \
        python3.12-venv \
        python3-pip \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Verify installations
RUN java -version && python3 --version

# Set working directory for Pterodactyl
WORKDIR /srv/daemon-data

# Default shell
SHELL ["/bin/bash", "-c"]

# Default command
CMD ["bash"]
