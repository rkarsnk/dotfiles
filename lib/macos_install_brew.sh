#!/bin/bash

# intel macOS
if [ -f "/usr/local/bin/brew" ]; then
  echo "homebrew for x86_64 mac has installed."
# ARM macOS
elif [ -f "/opt/homebrew/bin/brew" ]; then
  echo "homebrew for arm64 mac has installed."
fi
