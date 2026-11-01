#!/bin/sh
# Lays out the av archive in stage/: the start script at the top, and the
# game in lib/ with the data it reads at run time. Image/ is left out: it
# is only for the SDL version.
set -eu
rm -rf stage && mkdir -p stage/lib
cp asciiverse/gharena stage/gharena
cp gharena stage/lib/
cp -R GameData Series Design doc stage/lib/
cp license.txt readme.md history.txt PATCHES.md stage/
