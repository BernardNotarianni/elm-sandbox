#!/usr/bin/env bash

while true; do

    elm make HelloWorld.elm --output=helloworld.js

    inotifywait -qr -e modify -e create -e move -e delete . --exclude "\.\#.*"
done
