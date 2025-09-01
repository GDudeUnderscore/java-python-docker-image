# Multi-arch: Java 24 + Python 3.13
# Use official Eclipse Temurin 24 JDK image (multi-arch)
FROM eclipse-temurin:24-jdk

# Install Python 3.13 and pip
RUN apt-get update && apt-get install -y \
        python3.13 \
        python3.13-venv \
        python3.13-dev \
        python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Set python3 default
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.13 1

# Set working directory
WORKDIR /app
COPY . /app

# Install Python dependencies if requirements.txt exists
RUN if [ -f requirements.txt ]; then python3 -m pip install --no-cache-dir -r requirements.txt; fi

# Default command
CMD ["python3", "hapily.py"]
