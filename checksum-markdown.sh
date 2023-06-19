#!/opt/homebrew/bin/bash
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
#   curl -sSLf https://github.com/skyzyx/rg35xx-garlicos-macos-instructions/raw/main/checksum-markdown.sh | /opt/homebrew/bin/bash | pbcopy
#
# PRINTS TO STANDARD OUT (stdout)! This means you can pipe the output to
# `pbcopy` to copy it to your clipboard.
##

# Ensure that dependencies are installed.
if [[ $(/usr/bin/uname -o) == "Darwin" ]]; then
    brew install bash coreutils findutils gnu-sed
fi

# Available in Bash 4+.
shopt -s globstar

# Cleanup .DS_Store files first
# shellcheck disable=SC2038
find . -type f -name .DS_Store | xargs -I% rm -f "%"

# shellcheck disable=SC2016
cat << EOF
# Appendix: BIOS Checksums

> **IMPORTANT:** These checksums are for the BIOS files only. They do not include the \`scummvm\` directory (which comes with Garlic OS), nor the \`Databases/\` and \`Machines/\` directories that are required for Microsoft MSX emulation.

Most of the BIOS files used for emulation go into this root \`BIOS/\` directory.

These are sorted the way that Bash sorts things — numbers, then UPPER alpha, then lower alpha.

## How to verify checksums

1. With [Homebrew] installed, install the \`coreutils\` package. This will give you the \`md5sum\` command.

    \`\`\`bash
    brew install coreutils
    \`\`\`

1. Download the [bios.md5] file, and save it into the \`BIOS/\` directory. (Run this whole command at once.)

    \`\`\`bash
    curl --silent --show-error --location --fail \\
        https://github.com/skyzyx/rg35xx-garlicos-macos-instructions/raw/main/bios.md5 \\
        --output /Volumes/ROMS/BIOS/bios.md5
    \`\`\`

1. Then you can validate the checksums. If everything is OK, there will be no output. There will only be output if there is a problem.

    \`\`\`bash
    cd /Volumes/ROMS/BIOS/ && \\
    md5sum --ignore-missing --quiet --check bios.md5
    \`\`\`

## \`BIOS/\`

| File | MD5 Checksum |
|------|--------------|
$(md5sum --tag -- * 2> /dev/null | gsed 's/MD5 (/| `/g' | gsed 's/) = /` | `/g' | gsed 's/$/` |/g')

## \`BIOS/keropi/\`

Used for _Sharp X68000_ emulation.

| File | MD5 Checksum |
|------|--------------|
$(md5sum --tag -- keropi/* 2> /dev/null | gsed 's/MD5 (/| `/g' | gsed 's/) = /` | `/g' | gsed 's/$/` |/g')

## \`BIOS/np2/\`

Used for _NEC PC-9800 (PC-98) series_ emulation.

| File | MD5 Checksum |
|------|--------------|
$(md5sum --tag -- np2/* 2> /dev/null | gsed 's/MD5 (/| `/g' | gsed 's/) = /` | `/g' | gsed 's/$/` |/g')

## \`BIOS/xmil/\`

Used for _Sharp X1_ emulation.

| File | MD5 Checksum |
|------|--------------|
$(md5sum --tag -- xmil/* 2> /dev/null | gsed 's/MD5 (/| `/g' | gsed 's/) = /` | `/g' | gsed 's/$/` |/g')

[bios.md5]: https://github.com/skyzyx/rg35xx-garlicos-macos-instructions/raw/main/bios.md5
[Homebrew]: https://mac.install.guide/homebrew/index.html
EOF
