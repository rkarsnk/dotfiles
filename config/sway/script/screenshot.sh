#!/usr/bin/env bash
set -euo pipefail

filename=`date "+%Y_%m_%d_%H_%M_%S"`.png
grim -g "$(slurp)" $HOME/Pictures/ScreenShots/$filename

