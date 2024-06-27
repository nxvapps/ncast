#!/bin/bash

set -eou pipefail

export OBS_PORT="${OBS_PORT:-4455}"

if [ -z "$(ls -A /data)" ]; then
   echo "Copying default files and linking fs" | tee /var/log/ncast.log
   cp -rf /root/.config/obs-default /data/obs-studio
   ln -s /data/obs-studio /root/.config/obs-studio
fi

echo "Settings OBS Server Port: ${OBS_PORT}" | tee /var/log/ncast.log
sed -i -e "s/ServerPort=.*+/ServerPort=${OBS_PORT}/g" /root/.config/obs-studio/global.ini

echo "Setting OBS Password to APP_PASSWORD" | tee /var/log/ncast.log
sed -i -e "s/ServerPassword=.*+/ServerPassword=${APP_PASSWORD}/g" /root/.config/obs-studio/global.ini