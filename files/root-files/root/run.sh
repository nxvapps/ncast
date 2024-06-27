#!/bin/bash

# Set password from global, default to none
APP_PASSWORD="${APP_PASSWORD:-}"

if [ -z "${APP_PASSWORD}" ]; then
    echo "APP_PASSWORD variable is not set, this is insecure! Was this intentional?" | tee /var/log/ncast.log
fi

if [ -z "$(ls -A /data)" ]; then
   echo "Copying default files and linking fs" | tee /var/log/ncast.log
   cp -rf /root/.config/obs-default /data/obs
   ln -s /data/obs /root/.config/obs
fi

# Run nvidia-xconfig
echo "Running nvidia-xconfig" | tee /var/log/ncast.log
nvidia-xconfig

# Set passwords
sed -i -e "s/ServerPassword=.*+/ServerPassword=${APP_PASSWORD}/g" "/root/.config/obs-studio/global.ini"
echo "${APP_PASSWORD}" >> /root/.xprapasswd

echo "Starting app..." | tee /var/log/ncast.log 2>&1
systemctl start x11-gl-session
systemctl start xpra-web
