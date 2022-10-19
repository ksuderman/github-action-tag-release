# Container image that runs your code
FROM alpine:3.10

RUN apk update && apk add bash git
RUN mkdir /tmp/gh
WORKDIR /tmp/gh
RUN wget -O ghlinux.tar.gz https://github.com/cli/cli/releases/download/v2.14.4/gh_2.14.4_linux_amd64.tar.gz && \
    tar xzf ghlinux.tar.gz && \
    cp $(find . -name gh) /usr/bin && \

WORKDIR /
RUN rm -rf /tmp/gh

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
