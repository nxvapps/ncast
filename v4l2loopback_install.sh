#!/bin/bash

mkdir -p /etc/modules-load.d
echo "v4l2loopback" > /etc/modules-load.d/v4l2loopback.conf
modprobe v4l2loopback
