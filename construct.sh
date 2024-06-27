#!/bin/bash

set -eou pipefail
. ./.INFO

# This is the construction script. This is used to construct the environment
# for the build process.

# Move all overrides
cp -rf files vapp/
rm -f files

# Transfer project
cp -rf vapp/* ./
rm -rf vapp
