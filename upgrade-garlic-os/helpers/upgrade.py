import os
import pathlib
import shutil
import subprocess
import sys
import tempfile
import time
from textwrap import dedent

# Code in the `helpers/` directory.
from helpers.constants import *
from helpers.fs import *
from helpers.messages import *
from helpers.numbers import *

def determine_upgrade_plan(flags):
    flags.upgrade_path = pathlib.Path(flags.upgrade_path).resolve()
    flags.misc_volume = pathlib.Path(flags.misc_volume).resolve()
    flags.roms_volume = pathlib.Path(flags.roms_volume).resolve()

    if isPathExist(flags.misc_volume) == False:
        sys.exit(
            f"{cerror('[ERROR]')} The MISC volume does not exist at the path `{flags.misc_volume}`."
        )

    if isPathExist(flags.roms_volume) == False:
        sys.exit(
            f"{cerror('[ERROR]')} The ROMS volume does not exist at the path `{flags.roms_volume}`."
        )

    if isPathExist(flags.upgrade_path / "RG35XX-CopyPasteOnTopOfStock.7z.001") == False:
        sys.exit(
            f"{cerror('[ERROR]')} Cannot find archive file `{flags.upgrade_path / 'RG35XX-CopyPasteOnTopOfStock.7z.001'}`."
        )

    if isPathExist(flags.upgrade_path / "RG35XX-CopyPasteOnTopOfStock.7z.002") == False:
        sys.exit(
            f"{cerror('[ERROR]')} Cannot find archive file `{flags.upgrade_path / 'RG35XX-CopyPasteOnTopOfStock.7z.002'}`."
        )

    if flags.skip_interactive == False:
        print(
            dedent(
                f"""\
{cinfo("UPGRADE:")}

WHAT IS GOING TO HAPPEN:

    1. We will decompress the upgrade archive files into a temporary directory.

    2. We will update the files on the MISC volume.

    3. We will update the files on the ROMS volume.

    4. We will clean-up the temporary directory.

        ARCHIVE FILE 001: {flags.upgrade_path / "RG35XX-CopyPasteOnTopOfStock.7z.001"}
        ARCHIVE FILE 002: {flags.upgrade_path / "RG35XX-CopyPasteOnTopOfStock.7z.002"}
        MISC VOLUME: {flags.misc_volume}
        ROMS VOLUME: {flags.roms_volume}
                """.rstrip()
            )
        )

        print("")

        try:
            _ = input(PRESS_TO_CONTINUE)
        except KeyboardInterrupt:
            sys.exit(0)

    else:
        if flags.verbose >= 1:
            pr(crun("NOTE: --skip-interactive is enabled."))

def perform_upgrade(flags):
    if flags.no_upgrade == False:
        if flags.upgrade_path is None:
            sys.exit(
                f"{cerror('[ERROR]')} You must specify the directory containing the upgrade 7z archives with the `--upgrade-path` flag, \nor no upgrade at all with the `--no-upgrade` flag."
            )

        determine_upgrade_plan(flags)
        # ...and wait for an answer.

        print(HR)
        print("")

        tmpdirname = tempfile.mkdtemp(prefix="upgrade-garlic-os-")
        full_tmpdir = pathlib.Path(tmpdirname).resolve()

        print(cinfo("Decompressing the 7z archive into a temporary directory..."))
        cmd1 = [
            "7za",
            "x",
            "-y",
            "-t7z.split",
            str(flags.upgrade_path / "RG35XX-CopyPasteOnTopOfStock.7z.001"),
            "-o" + str(full_tmpdir),
        ]

        if flags.verbose >= 1:
            pr(crun(" ".join(cmd1)))

        subprocess.run(cmd1, text=True)
        print("")

        subprocess.run([
            "rm",
            "-Rf",
            str(full_tmpdir / "roms" / "Roms"),
        ], text=True)

        if flags.verbose >= 2:
            print(cinfo("Display a tree of the temporary directory..."))
            cmd1 = [
                "tree",
                str(full_tmpdir),
            ]

            if flags.verbose >= 2:
                pr(crun(" ".join(cmd1)))

            subprocess.run(cmd1, text=True)
            print("")

        print(cinfo(f"Make room for the upgrade on the {flags.misc_volume} volume..."))
        cmd1 = [
            "rm",
            "-Rf",
            str(flags.misc_volume / "uImage"),
        ]

        if flags.verbose >= 1:
            pr(crun(" ".join(cmd1)))

        subprocess.run(cmd1, text=True)
        print("Done.")
        print("")

        print(cinfo(f"Copy upgraded files to the {flags.misc_volume} volume..."))
        shutil.copytree(
            str(full_tmpdir / "misc"),
            str(flags.misc_volume),
            dirs_exist_ok=True,
        )
        print("")

        shutil.rmtree(tmpdirname)
