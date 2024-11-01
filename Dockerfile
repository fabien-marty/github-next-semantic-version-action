FROM alpine:latest

RUN apk add git curl
COPY download.sh /app/bin/

# Download version v0.5.3
RUN mkdir -p /app/bin && \
    cd /app/bin && \
    ./download.sh "https://api.github.com/repos/fabien-marty/github-next-semantic-version/releases/183066274" github-next-semantic-version && \
    chmod +x github-next-semantic-version 

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]