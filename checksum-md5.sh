#!/usr/bin/env bash
set -euo pipefail

##
# YOU. YEAH, YOU.
# This script is not for you.
##

##
# This file will generate checksums of the BIOS files. It requires modern Bash,
# newer than what Apple ships (because of the GPLv3 license). Requires packages
# installed from Homebrew.
#
# RUN THIS FROM YOUR BIOS DIRECTORY!
#
#   curl -sSLf https://github.com/skyzyx/rg35xx-garlicos-macos-instructions/raw/main/checksum-md5.sh | "$(brew --prefix)/bin/bash" | pbcopy
#
# PRINTS TO STANDARD OUT (stdout)! This means you can pipe the output to
# `pbcopy` to copy it to your clipboard.
##

# Available in Bash 4+.
shopt -s globstar

# Cleanup .DS_Store files first
# shellcheck disable=SC2038
gfind . -type f -name .DS_Store | gxargs -I% grm -f "%"

md5sum --binary -- ** 2> /dev/null |
    ggrep -v "*scummvm/" |
    ggrep -v "*Databases/" |
    ggrep -v "*Machines/" |
    ggrep -v "checksum*.sh"
