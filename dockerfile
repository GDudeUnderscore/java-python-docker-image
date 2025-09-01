# Use Eclipse Temurin JDK 24 as base (supports Linux)
FROM eclipse-temurin:24-jdk

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install Python 3.13 and common tools
RUN apt-get update && apt-get install -y \
    software-properties-common \
    wget \
    build-essential \
    python3.13 python3.13-venv python3.13-dev python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Make python3.13 default
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.13 1

# Set JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/jdk-24
ENV PATH="$JAVA_HOME/bin:$PATH"

# Verify installations
RUN python3 --version && java -version

# Default command
CMD ["bash"]
