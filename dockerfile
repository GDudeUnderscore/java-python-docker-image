FROM openjdk:24-ea-ubuntu

RUN apt-get update && apt-get install -y \
    python3.13 python3.13-venv python3.13-dev python3-pip \
    && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.13 1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
CMD ["bash"]
