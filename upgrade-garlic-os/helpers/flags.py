import argparse

def cli_flags():
    parser = argparse.ArgumentParser(
        description="Streamlines the process of upgrading Garlic OS and backing up the system.",
    )

    parser.add_argument(
        "--backup-path",
        "-b",
        help="The directory path in which to store the backup files. Required unless the `--no-backup` flag is set.",
    )

    parser.add_argument(
        "--misc-volume",
        "-M",
        help="The path to the MISC volume. The default value is `/Volumes/MISC`.",
        default="/Volumes/MISC",
    )

    parser.add_argument(
        "--roms-volume",
        "-R",
        help="The path to the ROMS volume. The default value is `/Volumes/ROMS`.",
        default="/Volumes/ROMS",
    )

    parser.add_argument(
        "--no-backup",
        help="Backups are performed by default. Set this flag if you definitely DO NOT WANT to backup.",
        action="store_true",
    )

    parser.add_argument(
        "--backup-roms-too",
        "-r",
        help="By default, the ROMS volume is backed up EXCEPT for the 'Roms' directory because this is not generally touched during the upgrade process. Set this flag to backup the 'Roms' directory as well.",
        action="store_true",
    )

    parser.add_argument(
        "--skip-interactive",
        "-y",
        help="There are a few places where this script will pause and ask you to read and confirm. Set this flag to skip those pauses and automatically confirm.",
        action="store_true",
    )

    parser.add_argument(
        '--verbose',
        '-v',
        help="Determine how verbose the output should be. This flag can be used multiple times to increase verbosity. The default value is 0.",
        action='count',
        default=0,
    )

    return parser.parse_args()
