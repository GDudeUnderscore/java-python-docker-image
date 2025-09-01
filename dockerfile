# -----------------------------
# Java 21 + Python 3.10 ARM64 Dockerfile
# Optimized for Pterodactyl
# -----------------------------

# Base image: Eclipse Temurin 21 JDK (ARM64, prebuilt)
FROM eclipse-temurin:21-jdk-jammy

# Set noninteractive for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install Python 3.10 and minimal dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        python3.10 \
        python3.10-venv \
        python3-pip \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Verify installations (optional, can remove in production)
RUN java -version && python3 --version

# Create and set the working directory for Pterodactyl
RUN mkdir -p /home/container
WORKDIR /home/container

# Do NOT set CMD here — Pterodactyl will run your server process automatically
# The startup command should be configured in the egg (e.g., java -jar server.jar)

# Default shell (optional, only if you exec into container)
SHELL ["/bin/bash", "-c"]
