# Use an ARM64-compatible base image
FROM arm64v8/debian:bullseye-slim

# Set environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-24-openjdk-arm64
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Install dependencies and Java 24
RUN apt-get update && \
    apt-get install -y \
    openjdk-24-jdk \
    python3.13 \
    python3.13-distutils \
    curl \
    ca-certificates \
    bash \
    && apt-get clean;

# Set up the container user
RUN useradd -m -s /bin/bash container
USER container
WORKDIR /home/container

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
