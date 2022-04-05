#!/bin/sh

# To use this script you need to specify the target node version with the NODE_VERSION variable

if [ -z "${NODE_VERSION}" ]; then
  echo "ERROR: 'NODE_VERSION' variable is not set!" >&2
  exit 1;
fi

RELEASE_NAME="node-v$NODE_VERSION-linux-x64"
ARCHIVE_NAME="$RELEASE_NAME.tar.xz"

wget "https://nodejs.org/dist/v$NODE_VERSION/$ARCHIVE_NAME"

tar --no-same-owner -xJf  "./$ARCHIVE_NAME" -C /usr/local/

rm "$ARCHIVE_NAME"

NODEJS_HOME="/usr/local/$RELEASE_NAME"

export PATH=$NODEJS_HOME/bin:$PATH

node --version
npm --version

