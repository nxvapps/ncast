#!/bin/bash

set -eoux pipefail
. ./.INFO

# This is the construction script. This is used to construct the environment
# for the build process.

# Move all overrides
cp -rf files vapp/
rm -rf files

# Transfer project
rm -rf vapp/.git
cp -rf vapp/* ./
rm -rf vapp

ls -lhta
ls -lhta files
