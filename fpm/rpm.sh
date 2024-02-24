#!/bin/bash

cp /bin/bash ./foobar.tmp

NAME="foobar"
VERSION="1.2.3"
LICENSE="gpl3"
MAINTAINER="foobar@example.com"
VENDOR="Example Inc"
DESCRIPTION="$(cat <<-EOF
Foobar is awesome.
Foobar is mix of foo and bar.
EOF
)"
URL="https://example.com/foobar"
BINARY="foobar.tmp=/usr/bin/foobar"
./fpm.sh --verbose                  \
      --input-type dir              \
      --output-type rpm             \
      --no-auto-depends             \
      --architecture "x86_64"       \
      --name "$NAME"                \
      --version "$VERSION"          \
      --license "$LICENSE"          \
      --maintainer "$MAINTAINER"    \
      --iteration 1                 \
      --vendor "$VENDOR"            \
      --description "$DESCRIPTION"  \
      --url "$URL"                  \
      "$BINARY"

rm ./foobar.tmp
