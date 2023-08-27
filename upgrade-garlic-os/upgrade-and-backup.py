#! /usr/bin/env python3
import argparse
import sys

MIN_PYTHON = (3, 8)
if sys.version_info < MIN_PYTHON:
    sys.exit(
        "This script requires Python {version} or newer.".format(
            version='.'.join([str(n) for n in MIN_PYTHON])
        )
    )

#-------------------------------------------------------------------------------
# arch.py --arch $(uname -m) --x86 amd64 --arm arm64

def main():
    parser = argparse.ArgumentParser(
        description="Return alternate CPU architecture identifiers. Only supports 64-bit Intel and ARM CPUs under Darwin/Linux.",
    )

    parser.add_argument("arch", help="The arch value from `uname -m`.")

    parser.add_argument(
        "--x86",
        help="If the arch value matches `x86_64`, return this value instead. Common choices are `amd64`."
    )

    parser.add_argument(
        "--arm",
        help="If the arch value matches `arm64`, return this value instead. Common choices are `aarch64`."
    )

    flags = parser.parse_args()

    if flags.arch is None:
        print("Pass the arch value from `uname -m`.")
        sys.exit(1)

    if (flags.arch == "x86_64" or flags.arch == "amd64") and flags.x86 is not None:
        print(flags.x86)
    elif (flags.arch == "arm64" or flags.arch == "aarch64") and flags.arm is not None:
        print(flags.arm)
    else:
        print(flags.arch)

# -----------------------------------------------------------------------------

if __name__ == "__main__":
    main()
