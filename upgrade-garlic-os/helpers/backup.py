import os
import pathlib
import shutil
import subprocess
import sys
import time
from textwrap import dedent

# Code in the `helpers/` directory.
from helpers.constants import *
from helpers.fs import *
from helpers.messages import *
from helpers.numbers import *

def determine_backup_plan(flags):
    flags.backup_path = pathlib.Path(flags.backup_path).resolve()
    flags.misc_volume = pathlib.Path(flags.misc_volume).resolve()
    flags.roms_volume = pathlib.Path(flags.roms_volume).resolve()

    misc_paths = getVolumePaths(
        flags.misc_volume,
        sort_list=True,
    )
    misc_volume_size = human(getVolumeSize(misc_paths))

    misc_volume_size

    if flags.backup_roms_too:
        roms_paths = getVolumePaths(
            flags.roms_volume,
            sort_list=True,
        )
        roms_volume_size = human(getVolumeSize(roms_paths))
    else:
        roms_paths = getVolumePaths(
            flags.roms_volume,
            exclude_dirs=['Roms'],
            sort_list=True,
        )
        roms_volume_size = human(getVolumeSize(roms_paths))

    if flags.verbose >= 3:
        print(cinfo("MISC VOLUME PATHS:"))
        for p in misc_paths:
            print(p)

        print("")

        print(cinfo("ROMS VOLUME PATHS:"))
        for p in roms_paths:
            print(p)

        print(HR)

    if isPathExist(flags.misc_volume) == False:
        sys.exit(
            f"{cerror('[ERROR]')} The MISC volume does not exist at the path `{flags.misc_volume}`."
        )

    if isPathExist(flags.roms_volume) == False:
        sys.exit(
            f"{cerror('[ERROR]')} The ROMS volume does not exist at the path `{flags.roms_volume}`."
        )

    if flags.skip_interactive == False:
        print(
            dedent(
                f"""\
{cinfo("BACKUP:")}

WHAT IS GOING TO HAPPEN:

    1. We will create a new disk image (sparse bundle), and mount it as a volume. (It may show up on
    your desktop while the backup is running.)

    2. We will use a tool called rsync to backup the files from your MISC and ROMS volumes to the
    disk image we create for your backup.

    3. We will unmount the disk image, then compress its contents into a `.tar.xz` file (which gets
    the best compression).

    4. The compressed file will be copied to the backup path, along with instructions for how to
    restore your backup if you ever need to.

        MISC VOLUME: {flags.misc_volume} ({misc_volume_size})
        ROMS VOLUME: {flags.roms_volume} ({roms_volume_size})
        INCLUDE ROMS DIRECTORY: {flags.backup_roms_too}
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

def perform_backup(flags):
    if flags.no_backup == False:
        if flags.backup_path is None:
            sys.exit(
                f"{cerror('[ERROR]')} You must specify a backup path with the `--backup-path` flag, or no backup at all with \nthe `--no-backup` flag."
            )

        determine_backup_plan(flags)
        # ...and wait for an answer.

        print(HR)
        print("")

        # Used as a unique identifier for the backup.
        UUID = getTimestamp()

        print(cinfo("Creating the macOS sparse bundle..."))
        cmd1 = [
            "hdiutil",
            "create",
            "-library",
            "SPUD",
            "-size",
            "512g",
            "-fs",
            "Case-sensitive APFS",
            "-type",
            "SPARSEBUNDLE",
            "-volname",
            f"RG35XX-GarlicOS-{UUID}", # This is only a name, not a proper file system path.
            str(pathlib.Path(f"RG35XX-GarlicOS-{UUID}.sparsebundle").resolve()),
        ]

        if flags.verbose >= 1:
            pr(crun(" ".join(cmd1)))

        subprocess.run(cmd1, text=True)
        print("")

        print(cinfo("Mounting the macOS sparse bundle as a disk image..."))
        cmd1 = [
            "hdiutil",
            "attach",
            str(pathlib.Path(f"RG35XX-GarlicOS-{UUID}.sparsebundle").resolve()),
            "-mountpoint",
            str(pathlib.Path(f"/Volumes/RG35XX-GarlicOS-Backup-{UUID}").resolve()),
        ]

        if flags.verbose >= 1:
            pr(crun(" ".join(cmd1)))

        subprocess.run(cmd1, text=True)
        print("")

        print(cinfo(f"Backing up {flags.misc_volume}..."))
        print(
            chilite(
                "If you see errors related to '.Spotlight-V100' and 'failed: Input/output error', you can ignore them."
            )
        )
        cmd1 = [
            "rsync",
            "--human-readable",
            "--archive",
            "--progress",
            "--delete",
            str(pathlib.Path("/Volumes/MISC").resolve()),
            str(pathlib.Path(f"/Volumes/RG35XX-GarlicOS-Backup-{UUID}").resolve()),
        ]

        if flags.verbose >= 1:
            pr(crun(" ".join(cmd1)))

        subprocess.run(cmd1, text=True)
        print("")

        roms_dir_status = "EXCLUDING"
        if flags.backup_roms_too:
            roms_dir_status = "INCLUDING"

        print(
            cinfo(
                f"Backing up {flags.roms_volume} {roms_dir_status} the ROMS/Roms directory..."
            )
        )
        print(
            chilite(
                "If you see errors related to '.Spotlight-V100' and 'failed: Input/output error', you can ignore them."
            )
        )

        # Determine the correct command to run.
        cmd1 = [
            "rsync",
            "--human-readable",
            "--archive",
            "--progress",
            "--delete",
        ]
        exclude_roms_cmd = [
            "--exclude",
            "ROMS/Roms",
        ]
        end_roms_cmd = [
            str(pathlib.Path("/Volumes/ROMS").resolve()),
            str(pathlib.Path(f"/Volumes/RG35XX-GarlicOS-Backup-{UUID}").resolve()),
        ]

        if flags.backup_roms_too == False:
            cmd1.extend(exclude_roms_cmd)

        cmd1.extend(end_roms_cmd)

        if flags.verbose >= 1:
            pr(crun(" ".join(cmd1)))

        subprocess.run(cmd1, text=True)
        print("")

        print(cinfo("Cleaning unnecessary macOS junk from the GarlicOS file system..."))
        cmd1 = [
            "bash",
            str(pathlib.Path(os.getcwd() + "/helpers/cleanup-macos-files.sh").resolve()),
            UUID,
        ]

        if flags.verbose >= 1:
            pr(crun(" ".join(cmd1)))

        subprocess.run(cmd1, text=True)
        print("")

        time.sleep(3)

        print(cinfo(f"Ejecting the backup volume..."))
        cmd1 = [
            "hdiutil",
            "eject",
            str(pathlib.Path(f"/Volumes/RG35XX-GarlicOS-Backup-{UUID}").resolve()),
        ]

        if flags.verbose >= 1:
            pr(crun(" ".join(cmd1)))

        subprocess.run(cmd1, text=True)
        print("")

        time.sleep(1)

        print(cinfo(f"Compacting the macOS sparse bundle..."))
        cmd1 = [
            "hdiutil",
            "compact",
            str(pathlib.Path(f"RG35XX-GarlicOS-{UUID}.sparsebundle").resolve()),
        ]

        if flags.verbose >= 1:
            pr(crun(" ".join(cmd1)))

        subprocess.run(cmd1, text=True)
        print("")

        # Compress
        print(cinfo(f"Compressing the macOS sparse bundle into an archive..."))
        cmd1 = [
            "gtar",
            "-cJvf",
            str(pathlib.Path(f"RG35XX-GarlicOS-{UUID}.tar.xz").resolve()),
            f"RG35XX-GarlicOS-{UUID}.sparsebundle",
        ]

        if flags.verbose >= 1:
            pr(crun(" ".join(cmd1)))

        subprocess.run(cmd1, text=True)
        print("")

        # NOTE: Native tar implementation is significantly faster than the
        # Python implementation. So the Python implementation is commented out.

        # tar = tarfile.open(f"RG35XX-GarlicOS-{UUID}.tar.xz", "w:xz")
        # # The shutil.make_archive() implementation does not appear to provide
        # # output. So we do it ourselves.
        # for file_name in glob.glob(
        #         os.path.join(
        #             f"RG35XX-GarlicOS-{UUID}.sparsebundle",
        #             "*",
        #         ),
        #         recursive=True,
        # ):
        #     print(f"Adding {file_name}...")
        #     tar.add(file_name, os.path.basename(file_name))

        # tar.close()
        # print("")

        # Copy to backup directory
        print(cinfo(f"Copying RG35XX-GarlicOS-{UUID}.tar.xz to {flags.backup_path}..."))
        shutil.copy2(
            pathlib.Path(f"RG35XX-GarlicOS-{UUID}.tar.xz").resolve(),
            flags.backup_path,
        )
        print("Done.")
        print("")

        # Copy restoration instructions to backup dir

        print(cinfo("Cleaning up..."))
        shutil.rmtree(f"RG35XX-GarlicOS-{UUID}.sparsebundle")
        os.remove(pathlib.Path(f"RG35XX-GarlicOS-{UUID}.tar.xz").resolve())
        print("Done.")
        print("")
