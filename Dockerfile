# Inspired by https://github.com/mumoshu/dcind
FROM ubuntu:19.10
LABEL maintainer="Dmitry Matrosov <amidos@amidos.me>"

ENV DOCKER_VERSION=18.09.8 \
    DOCKER_COMPOSE_VERSION=1.24.1

# Install Docker and Docker Compose
RUN apt-get update
RUN apt-get install -y bash curl util-linux lvm2 python-pip libpython-dev libffi-dev libssl-dev gcc libc-dev make iptables iproute2 && \
    curl https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz | tar zx && \
    mv /docker/* /bin/ && \
    chmod +x /bin/docker* && \
    pip install docker-compose==${DOCKER_COMPOSE_VERSION} && \
    rm -rf /root/.cache

RUN apt-get update
RUN apt-get install -y git

# Include functions to start/stop docker daemon
COPY docker-lib.sh /docker-lib.sh
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]
