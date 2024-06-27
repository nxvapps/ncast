#!/bin/bash

echo "Starting X11 session!"
while true
do
    /usr/bin/xinit -- /usr/bin/Xvfb :100 -noreset -nolisten tcp +extension GLX +extension RANDR +extension RENDER
    sleep 5
    echo "Restarting X11 session!"
done
