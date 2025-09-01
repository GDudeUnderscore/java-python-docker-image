FROM python:3.13.7-bullseye

# Install OpenJDK 24 (Adoptium)
RUN apt-get update && apt-get install -y wget tar ca-certificates \
    && wget https://github.com/adoptium/temurin24-binaries/releases/latest/download/OpenJDK24U-jdk_aarch64_linux_hotspot.tar.gz \
    && tar -xzf OpenJDK24U-jdk_aarch64_linux_hotspot.tar.gz -C /usr/lib/jvm \
    && rm OpenJDK24U-jdk_aarch64_linux_hotspot.tar.gz

ENV JAVA_HOME=/usr/lib/jvm/jdk-24
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Pterodactyl user
RUN useradd -m -s /bin/bash container
USER container
WORKDIR /home/container
CMD ["/bin/bash"]
