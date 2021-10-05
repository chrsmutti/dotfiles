#!/usr/bin/env bash
# A script used to install some much needed functionality using brew.

if [[ "$(uname)" != "Darwin"* ]]; then
    echo "This script is only for macos"
    exit 0
fi

brew install starship
brew install git-delta