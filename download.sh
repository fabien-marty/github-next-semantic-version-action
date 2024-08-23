#!/bin/sh

ARCH=${1:-linux-amd64}
echo "ARCH=${ARCH}"

LOCATION=$(curl -s https://api.github.com/repos/fabien-marty/github-next-semantic-version/releases/latest \
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
