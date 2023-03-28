# Installing Garlic OS on your Anbernic RG35XX using macOS

Instructions for installing Garlic OS on your Anbernic RG35XX using macOS. Adapted from <https://pastebin.com/YV1Va5JL>, originally written by _A GUEST_ on 2022-12-30.

Each step is explained in English with the corresponding terminal command below it. These instructions hould work without problem on any modern macOS — with either Intel or Apple Silicon CPUs. Tested on macOS Ventura 13.3 on both an Intel i9 chip, and an Apple M1 Max chip.

> **IMPORTANT:** You will end up formatting the ROM partition completely, so it is best to do this before you waste time copying any rom files over.

## Prerequisites

* A _relatively_ [recent version of macOS](https://gist.github.com/skyzyx/225b59847be31b39d3d19c3a1c006862).
   
* Using _Terminal.app_ (or alternatives).

* You have [Homebrew](https://brew.sh) installed. ([Installation](https://mac.install.guide/homebrew/index.html) is outside the scope of this tutorial, but it's pretty fundamental if you do technical things on your Mac.)

    * This includes installing the [Xcode CLI tools](https://mac.install.guide/homebrew/2.html) (a much smaller download than the _entire_ Xcode).

## Preparing the card

> **Optional:** This only applies if you are using a card that is _already_ formatted for the Anbernic RG35XX’s OS. If you're beginning with a blank card, skip ahead.

1. Back up the `CFW/` folder from the _ROMS_ partition.

1. If the image named both partitions _No Name_, then rename the one with the `CFW/` folder as _ROMS_ and the other partition as _MISC_ before starting this.

    This can be done in Finder the same way as renaming any other file.

## Installing gdisk

1. Install `gdisk` using Homebrew.

    ```bash
    brew install --cask gdisk
    ```
 
1. Use `diskutil` (installed by default on macOS) to view the list of mounted drives and look for the microSD card path. I have _several_ external hard drives, and mine was `/dev/disk11` with had four partitions.

    ```bash
    diskutil list
    ```

    ```plain
    /dev/disk11 (internal, physical):
    #:                       TYPE NAME                    SIZE       IDENTIFIER
    0:      GUID_partition_scheme                        *31.9 GB    disk11
    1:       Microsoft Basic Data MISC                    10.5 MB    disk11s1
    2:       Microsoft Basic Data                         536.9 MB   disk11s2
    3:       Microsoft Basic Data                         53.5 MB    disk11s3
    4:       Microsoft Basic Data ROMS                    3.4 GB     disk11s4
    ```

1. Launch `gdisk` using `sudo`. You will likely need to enter your password to authenticate.

    > **NOTE:** `sudo` grants administrative permissions to your user, as if to say "super user, do this." If you don't use `sudo` it will launch, but it will fail on some of the later steps.

    ```bash
    sudo gdisk
    ```
