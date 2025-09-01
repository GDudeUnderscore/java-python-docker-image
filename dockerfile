# Use an ARM64-compatible Debian slim base image
FROM debian:bullseye-slim

# Set environment variables for Java
ENV JAVA_HOME=/usr/lib/jvm/java-24-openjdk-arm64
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Install dependencies: Java 24, Python 3.13, curl, bash
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        ca-certificates \
        bash \
        python3.13 \
        python3.13-distutils \
        openjdk-24-jdk \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create Pterodactyl-compatible user
RUN useradd -m -s /bin/bash container
USER container
WORKDIR /home/container

# Default command (can be overridden by Pterodactyl startup)
CMD ["/bin/bash"]
