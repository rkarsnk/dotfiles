#!/usr/bin/env bash
set -euo pipefail

slop=$(slop -f "%g") || exit 1
read -r G < <(echo $slop)
filename=`date "+%Y_%m_%d_%H_%M_%S"`.png
import -window root -crop $G $HOME/Pictures/ScreenShots/$filename