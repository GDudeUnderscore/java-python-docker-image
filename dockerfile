# Start from official Python 3.13 image (multi-arch)
FROM python:3.13-slim

# Install curl/wget for downloading JDK
RUN apt-get update && apt-get install -y wget unzip ca-certificates && rm -rf /var/lib/apt/lists/*

# Install Java 24 (multi-arch) via Adoptium Temurin
RUN wget https://github.com/adoptium/temurin24-binaries/releases/latest/download/OpenJDK24U-jdk_aarch64_linux_hotspot.tar.gz -O /tmp/jdk24.tar.gz \
    && mkdir -p /usr/lib/jvm \
    && tar -xzf /tmp/jdk24.tar.gz -C /usr/lib/jvm \
    && rm /tmp/jdk24.tar.gz \
    && update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-24/bin/java 1 \
    && update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk-24/bin/javac 1

# Set working directory
WORKDIR /app
COPY . /app

# Install Python dependencies
RUN if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi

CMD ["python3", "hapily.py"]
