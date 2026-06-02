#!/bin/sh

if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
fi

if [ -f "yarn.lock" ]; then
    yarn
fi

if [ -f "package-lock.json" ]; then
    npm install
fi

/usr/bin/entrypoint.sh --bind-addr 0.0.0.0:8443
