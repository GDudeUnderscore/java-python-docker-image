FROM debian:bullseye-slim

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    bash \
    build-essential \
    wget \
    libssl-dev \
    zlib1g-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libffi-dev \
    libbz2-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Python 3.13
RUN wget https://www.python.org/ftp/python/3.13.7/Python-3.13.7.tgz \
    && tar xvf Python-3.13.7.tgz \
    && cd Python-3.13.7 \
    && ./configure --enable-optimizations \
    && make -j$(nproc) \
    && make altinstall \
    && cd .. \
    && rm -rf Python-3.13.7 Python-3.13.7.tgz

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
