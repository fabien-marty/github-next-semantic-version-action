FROM alpine:latest

RUN apk add git curl
COPY download.sh /app/bin/

# Download version v0.2.1
RUN mkdir -p /app/bin && \
    cd /app/bin && \
    ./download.sh "https://api.github.com/repos/fabien-marty/github-next-semantic-version/releases/171818257" && \
    chmod +x github-next-semantic-version 

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]