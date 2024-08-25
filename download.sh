#!/bin/sh

URL=$1
if test "${URL}" = ""; then
    echo "ERROR: missing URL"
    exit 1
fi
echo "URL=${URL}"

ARCH=${2:-linux-amd64}
echo "ARCH=${ARCH}"

LOCATION=$(curl -s "${URL}" \
| grep "browser_download_url" \
| grep "${ARCH}" \
| grep -v "md5" \
| awk '{ print $2 }' \
| sed 's/,$//'       \
| sed 's/"//g' )

if test "${LOCATION}" = ""; then
    echo "ERROR: can't find the download location"
    exit 1
fi

echo "Downloading $LOCATION..."
curl -L -o github-next-semantic-version "${LOCATION}"
