#! /usr/bin/env bash

DIR="$HOME/Screenshots"

NOW="$(date -Ins)"

DATETIME="$(date -d"${NOW}" +%Y%m%d-%H%M%S)"
FILE="$DIR/$DATETIME.png"

#mkdir -p "$DIR" && ln -nfs "$DIR" "$SCREENSHOT_DIR/latest"

import "$FILE"
xclip -i "$FILE" -selection clipboard -target image/png
