# Use Amazon Corretto 24 as the base image
FROM amazoncorretto:24

# Install Python 3.13 and required packages
RUN yum update -y && \
    yum install -y \
    python3.13 \
    python3.13-devel \
    python3.13-venv \
    python3-pip && \
    alternatives --install /usr/bin/python3 python3 /usr/bin/python3.13 1 && \
    rm -rf /var/cache/yum

# Set the working directory
WORKDIR /app

# Set the default command
CMD ["bash"]
