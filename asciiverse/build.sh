#!/bin/sh
# Builds GearHead: Arena's ASCII version (no SDL) with Free Pascal 3.2.
# The binary is fully static on Linux (FPC's own runtime, no libc) and
# links only the system libraries on macOS.
#   sh asciiverse/build.sh
# Leaves ./gharena; unit files go to build/.
set -eu
mkdir -p build
fpc -O2 -Xs -FUbuild gharena.pas
