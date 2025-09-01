FROM debian:bullseye-slim

# Install basic dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    bash \
    wget \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Python 3.13 prebuilt
RUN wget https://www.python.org/ftp/python/3.13.7/Python-3.13.7-aarch64-linux.tar.xz \
    && tar -xf Python-3.13.7-aarch64-linux.tar.xz -C /usr/local/ \
    && rm Python-3.13.7-aarch64-linux.tar.xz
ENV PATH="/usr/local/Python-3.13.7/bin:${PATH}"

# Install OpenJDK 24
RUN wget https://github.com/adoptium/temurin24-binaries/releases/latest/download/OpenJDK24U-jdk_aarch64_linux_hotspot.tar.gz \
    && tar -xzf OpenJDK24U-jdk_aarch64_linux_hotspot.tar.gz -C /usr/lib/jvm \
    && rm OpenJDK24U-jdk_aarch64_linux_hotspot.tar.gz
ENV JAVA_HOME=/usr/lib/jvm/jdk-24
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Pterodactyl user
RUN useradd -m -s /bin/bash container
USER container
WORKDIR /home/container

# Default command
CMD ["/bin/bash"]
