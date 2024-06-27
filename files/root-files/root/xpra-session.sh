#!/bin/bash

cleanup() {
    /usr/bin/xpra stop :100
    exit 0
}

trap cleanup SIGINT

echo "Starting X11 session!"
while true
do
    /usr/bin/xpra start --use-display :100 --username=ncast --password-file=/root/.xprapasswd --no-daemon --bind-tcp=0.0.0.0:7777
    sleep 5
    echo "Restarting X11 session!"
done
