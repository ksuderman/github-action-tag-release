# Container image that runs your code
FROM alpine:3.10

RUN apk update && apk add bash git
WORKDIR /tmp
RUN wget -O ghlinux.tar.gz https://github.com/cli/cli/releases/download/v2.14.4/gh_2.14.4_linux_amd64.tar.gz && \
    tar xzf ghlinux.tar.gz && \
    cp $(find . -name gh) /usr/bin && \
    rm -rf gh_2.14.4_linux_amd64 && \
    rm ghlinux.tar.gz

WORKDIR /
# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
