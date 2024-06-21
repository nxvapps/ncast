#!/bin/bash

export XDG_RUNTIME_DIR="/run/user/0"
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/0/bus"
exec obs
