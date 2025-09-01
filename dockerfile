# Use Eclipse Temurin 21 JDK (ARM64)
FROM eclipse-temurin:21-jdk-jammy

ENV DEBIAN_FRONTEND=noninteractive

# Install Python 3.10
RUN apt-get update && apt-get install -y --no-install-recommends \
        python3.10 \
        python3.10-venv \
        python3-pip \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set working directory for Pterodactyl
RUN mkdir -p /home/container
WORKDIR /home/container

# Make sure container does not start jshell by default
CMD []

# Optional: shell if you exec into container
SHELL ["/bin/bash", "-c"]
