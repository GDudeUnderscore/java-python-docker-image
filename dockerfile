FROM eclipse-temurin:21-jdk-jammy

ENV DEBIAN_FRONTEND=noninteractive

# Install Python 3.10
RUN apt-get update && apt-get install -y --no-install-recommends \
        python3.10 \
        python3.10-venv \
        python3-pip \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
RUN mkdir -p /home/container
WORKDIR /home/container

# Clear any ENTRYPOINT from base image
ENTRYPOINT []

# Default command to keep container alive; Pterodactyl overrides it
CMD ["sleep", "infinity"]

# Optional: shell if you exec into container manually
SHELL ["/bin/bash", "-c"]
