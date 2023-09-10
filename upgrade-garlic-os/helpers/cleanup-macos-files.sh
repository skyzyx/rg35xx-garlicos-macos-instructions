#!/usr/bin/env bash
set -euo pipefail

##
# YOU. YEAH, YOU.
# This script is not for you.
##

UUID="$1"

##
# Python calling out to execute shell commands isn't my favorite. It's easy to
# be wrong; it's easy to be insecure. But the native commands are an order of
# magnitude more performant than pure Python, and we're working with around 1 GB
# of data at minimum.
#
# But also, Python's subprocess library doesn't appear to like the Unix `|` pipe
# character very much, and it keeps bombing out in testing. So, we'll wrap what
# we need in a simple shell script, and have Python execute that. Perhaps Python
# could do it if I introduced additional gymnastics, but I think that would
# further hurt the clarity and security of the code.
#
# I feel like this is the lesser of two evils.
#
# Lastly, we're using the GNU flavor of CLI tools instead of macOS's built-in
# BSD-flavored tools. Install via Homebrew, and use the `g` prefix so that
# users don't need to mess with their shell $PATH or anything.
##

# Clean-up ".DS_Store" files.
gfind "/Volumes/RG35XX-GarlicOS-Backup-${UUID}/" -type f -name ".DS_Store" -print0 | gxargs -0 -I% grm -fv "%"

# Clean-up "._*" files.
gfind "/Volumes/RG35XX-GarlicOS-Backup-${UUID}/" -type f -name "._*" -print0 | gxargs -0 -I% grm -fv "%"

# Clean-up ".Trashes", ".fseventsd", ".Spotlight-V100", and ".TemporaryItems" directories.
gfind "/Volumes/RG35XX-GarlicOS-Backup-${UUID}/" -type d \( -name ".Trashes" -o -name ".fseventsd" -o -name ".Spotlight-V100" -o -name ".TemporaryItems" \) -print0 | gxargs -0 -I% grm -Rfv "%"
