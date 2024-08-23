FROM alpine:latest

RUN apk add git curl
COPY download.sh /app/bin/
RUN mkdir -p /app/bin && cd /app/bin && ./download.sh && chmod +x github-next-semantic-version 

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
