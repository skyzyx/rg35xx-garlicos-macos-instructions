#! /usr/bin/env python3
import platform
import sys
from textwrap import dedent

# Code in the `helpers/` directory.
from helpers.backup import *
from helpers.flags import *
from helpers.messages import *

#-------------------------------------------------------------------------------
# Bail-out early if we don't meet requirements.

MIN_PYTHON = (3, 11)
if sys.version_info < MIN_PYTHON:
    sys.exit(
        "[ERROR] This script requires Python {version} or newer, which can be installed with Homebrew <https://brew.sh>. You are using Python {sys_version}.".format(
            version='.'.join([str(n) for n in MIN_PYTHON]),
            sys_version='.'.join([str(n) for n in sys.version_info[:3]]),
        )
    )

if platform.system() != "Darwin":
    sys.exit(
        dedent(
            f"""\
            {cerror("[ERROR]")} This script relies on OS-level patterns only supported by macOS, and is not
            designed to run on any other platform. Doing so is explicitly unsupported.
            """.rstrip()
        )
    )

#-------------------------------------------------------------------------------

def main():
    flags = cli_flags()

    # Backup first.
    #
    # Note: The Snyk IDE extension flags this as unsanitized input that flows to
    # the file system. While technically true, this script is only meant to run
    # locally, and on a Mac (of which the world has very few web servers). The
    # `pathlib` library is also used to validate paths and ensure they are valid
    # and non-malicious.
    perform_backup(flags)

    # Upgrade second.

# -----------------------------------------------------------------------------

if __name__ == "__main__":
    main()
