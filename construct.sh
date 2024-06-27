#!/bin/bash

set -eou pipefail
. ./.INFO

# This is the construction script. This is used to construct the environment
# for the build process.

# Clone the base repo
git clone https://github.com/nxvapps/vapp.git

# Move all overrides
if [ -d files ]; then
    cp -rf files vapp/
    rm -rf files
fi

# Transfer project
rm -rf vapp/.git
cp -rf vapp/* ./
rm -rf vapp
