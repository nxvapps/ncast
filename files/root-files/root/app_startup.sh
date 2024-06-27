#!/bin/bash

set -eou pipefail

if [ -z "$(ls -A /data)" ]; then
   echo "Copying default files and linking fs" | tee /var/log/ncast.log
   cp -rf /root/.config/obs-default /data/obs
   ln -s /data/obs /root/.config/obs
fi
