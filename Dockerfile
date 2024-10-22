FROM alpine:latest

RUN apk add git curl
COPY download.sh /app/bin/

# Download version v0.3.1
RUN mkdir -p /app/bin && \
    cd /app/bin && \
    ./download.sh "https://api.github.com/repos/fabien-marty/github-next-semantic-version/releases/181257914" && \
    chmod +x github-next-semantic-version 

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]