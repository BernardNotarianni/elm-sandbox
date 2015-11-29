#!/usr/bin/env bash

while true; do

    elm make Main.elm --output=main.js

    inotifywait -qr -e modify -e create -e move -e delete . --exclude "\.\#.*" --exclude "\.git"
done
