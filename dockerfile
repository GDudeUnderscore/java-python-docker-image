FROM eclipse-temurin:24-jdk

# Install prerequisites
RUN apt-get update && apt-get install -y software-properties-common wget build-essential

# Add deadsnakes PPA
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update && apt-get install -y \
        python3.13 python3.13-venv python3.13-dev python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Set python3 default
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.13 1

WORKDIR /app
COPY . /app

# Optional: install Python deps
RUN if [ -f requirements.txt ]; then python3 -m pip install --no-cache-dir -r requirements.txt; fi

CMD ["python3", "hapily.py"]
