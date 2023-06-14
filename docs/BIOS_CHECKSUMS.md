# Appendix: BIOS Checksums

> **IMPORTANT:** These checksums are for the BIOS files only. They do not include the `scummvm` directory (which comes with Garlic OS), nor the `Databases/` and `Machines/` directories that are required for Microsoft MSX emulation.

Most of the BIOS files used for emulation go into this root `BIOS/` directory.

These are sorted the way that Bash sorts things — numbers, then UPPER alpha, then lower alpha.

## How to verify checksums

1. With [Homebrew] installed, install the `coreutils` package. This will give you the `md5sum` command.

    ```bash
    brew install coreutils
    ```

1. Download the [bios.md5] file, and save it into the `BIOS/` directory. (Run this whole command at once.)

    ```bash
    curl --silent --show-error --location --fail \
        https://github.com/skyzyx/rg35xx-garlicos-macos-instructions/raw/main/bios.md5 \
        --output /Volumes/ROMS/BIOS/bios.md5
    ```

1. Then you can validate the checksums. If everything is OK, there will be no output. There will only be output if there is a problem.

    ```bash
    cd /Volumes/ROMS/BIOS/ && \
    md5sum --ignore-missing --quiet --check bios.md5
    ```

## `BIOS/`

| File                        | MD5 Checksum                       |
|-----------------------------|------------------------------------|
| `000-lo.lo`                 | `fc7599f3f871578fe9a0453662d1c966` |
| `3do_arcade_saot.bin`       | `8970fc987ab89a7f64da9f8a8c4333ff` |
| `5200.rom`                  | `281f20ea4320404ec820fb7ec0693b38` |
| `7800 BIOS (E).rom`         | `397bb566584be7b9764e7a68974c4263` |
| `7800 BIOS (U).rom`         | `0763f1ffb006ddbe32e52d497ee848ae` |
| `ATARIBAS.ROM`              | `0bac0c6a50104045d902df4503a4c30b` |
| `ATARIOSA.ROM`              | `eb1f32f5d9f382db1bbfb8d7f9cb343a` |
| `ATARIOSB.ROM`              | `a3e8d617c95d08031fe1b20d541434b2` |
| `BS-X.bin`                  | `fed4d8242cfbed61343d53d48432aced` |
| `PSXONPSP660.BIN`           | `c53ca5908936d412331790f4426c6c33` |
| `STBIOS.bin`                | `d3a44ba7d42a74d3ac58cb9c14c6a5ca` |
| `bios.gg`                   | `672e104c3be3a238301aceffc3b23fd6` |
| `bios.md5`                  | `8e6590039bcd357d859d7c62a2a5f7f0` |
| `bios.min`                  | `1e4fb124a3a886865acb574f388c803d` |
| `bios_CD_E.bin`             | `e66fa1dc5820d254611fdcdba0662372` |
| `bios_CD_J.bin`             | `278a9397d192149e84e820ac621a8edd` |
| `bios_CD_U.bin`             | `2efd74e3232ff260e371b99f84024f7f` |
| `bios_E.sms`                | `840481177270d5642a14ca71ee72844c` |
| `bios_J.sms`                | `24a519c53f67b00640d0048ef7089105` |
| `bios_MD.bin`               | `d3293ebaaa7f4eb2a6766b68a0fb4609` |
| `bios_U.sms`                | `840481177270d5642a14ca71ee72844c` |
| `bubsys.zip`                | `f81298afd68a1a24a49a1a2d9f087964` |
| `c52.bin`                   | `f1071cdb0b6b10dde94d3bc8a6146387` |
| `cchip.zip`                 | `df6f8a3d83c028a5cb9f2f2be60773f3` |
| `channelf.zip`              | `2f2f8de3827ae1faf2495e497ca95232` |
| `checksum.sh`               | `0a04be2e83b236e420c7f300fd9aa7e7` |
| `cnebula.zip`               | `c683cb5dc4ef34ba43de281be67f1a6b` |
| `coleco.rom`                | `2c66f5911e5b42b8ebe113403548eee7` |
| `coleco.zip`                | `94915714a814a84f7c292e6db71f3ad2` |
| `decocass.zip`              | `9c915f8fc83b893e8e30273480a2c1a6` |
| `disksys.rom`               | `ca30b50f880eb660a320674ed365ef7a` |
| `exec.bin`                  | `62e761035cb657903761800f4437b8af` |
| `fdsbios.zip`               | `c26bf1744cb7f6ffe441f463870321f8` |
| `g7400.bin`                 | `c500ff71236068e0dc0d0603d265ae76` |
| `gb_bios.bin`               | `32fbbd84168d3482956eb3c5051637f5` |
| `gba_bios.bin`              | `a860e8c0b6d573d191e4ec7db1b1e4f6` |
| `gbc_bios.bin`              | `dbfce9db9deaa2567f6a84fde55f9680` |
| `goldstar.bin`              | `8639fd5e549bd6238cfee79e3e749114` |
| `grom.bin`                  | `0cd5946c6473e42e8e4c2137785e427f` |
| `isgsm.zip`                 | `4a56d56e2219c5e2b006b66a4263c01c` |
| `jopac.bin`                 | `279008e4a0db2dc5f1c048853b033828` |
| `kick33180.A500`            | `85ad74194e87c08904327de1a9443b7a` |
| `kick34005.A500`            | `3fde40288bd372599c4ec074522fc25c` |
| `kick34005.CDTV`            | `89da1838a24460e4b93f4f0c5d92d48d` |
| `kick37175.A500`            | `dc10d7bdd1b6f450773dfb558477c230` |
| `kick37350.A600`            | `465646c9b6729f77eea5314d1f057951` |
| `kick39106.A1200`           | `b7cc148386aa631136f510cd29e42fc3` |
| `kick39106.A4000`           | `9b8bdd5a3fd32c2a5a6f5b1aefc799a5` |
| `kick40060.CD32`            | `5f8924d013dd57a89cf349f4cdedc6b1` |
| `kick40060.CD32.ext`        | `bb72565701b1b6faece07d68ea5da639` |
| `kick40063.A600`            | `0b839c665635a249c5736118c68a69a7` |
| `kick40068.A1200`           | `646773759326fbac3b2311fd8c8793ee` |
| `kick40068.A4000`           | `9bdedde6a4f33555b4a270c8ca53297d` |
| `lynxboot.img`              | `fcd403db69f54290b51035d82f835e7b` |
| `midssio.zip`               | `5904b0de768d1d506e766aa7e18994c1` |
| `msx.zip`                   | `25a8912d7bf3cdad9beaa6d5cc14ea38` |
| `namcoc69.zip`              | `ad9af7a9560cad74f1644328213748f6` |
| `namcoc70.zip`              | `aa569a303793510b2b4173480148de4b` |
| `namcoc75.zip`              | `17516c33298e52424ffb58afc2ad208c` |
| `neocd.bin`                 | `f39572af7584cb5b3f70ae8cc848aba2` |
| `neocd_f.rom`               | `8834880c33164ccbe6476b559f3e37de` |
| `neocdz.zip`                | `62d56b126e78f3d82faa4ee8a92c3e82` |
| `neogeo.zip`                | `67682655fa5fb32831e28429643e26c7` |
| `ngp.zip`                   | `5bc25f80395a68790a69b7eb3e57b897` |
| `nmk004.zip`                | `bfacf1a68792d5348f93cf724d2f1dda` |
| `o2rom.bin`                 | `562d5ebf9e030a40d6fabfc2f33139fd` |
| `panafz1.bin`               | `f47264dd47fe30f73ab3c010015c155b` |
| `panafz10-norsa.bin`        | `1477bda80dc33731a65468c1f5bcbee9` |
| `panafz10.bin`              | `51f2f43ae2f3508a14d9f56597e2d3ce` |
| `panafz10e-anvil-norsa.bin` | `cf11bbb5a16d7af9875cca9de9a15e09` |
| `panafz10e-anvil.bin`       | `a48e6746bd7edec0f40cff078f0bb19f` |
| `panafz1j-norsa.bin`        | `f6c71de7470d16abe4f71b1444883dc8` |
| `panafz1j.bin`              | `a496cfdded3da562759be3561317b605` |
| `pcfx.rom`                  | `08e36edbea28a017f79f8d4f7ff9b6d7` |
| `pgm.zip`                   | `653e991a39e867354d090c3394157d1c` |
| `sanyotry.bin`              | `35fa1a1ebaaeea286dc5cd15487c13ea` |
| `scph1001.bin`              | `924e392ed05558ffdb115408c263dccf` |
| `scph101.bin`               | `6e3735ff4c7dc899ee98981385f6f3d0` |
| `scph5501.bin`              | `490f666e1afb15b7362b406ed1cea246` |
| `scph7001.bin`              | `1e68c231d0896b7eadcad1d7d8e76129` |
| `sgb_bios.bin`              | `d574d4f9c12f305074798f54c091a8b4` |
| `skns.zip`                  | `49e192febe2f011d9be44ebc69129080` |
| `sl31253.bin`               | `ac9804d4c0e9d07e33472e3726ed15c3` |
| `sl31254.bin`               | `da98f4bb3242ab80d76629021bb27585` |
| `sl90025.bin`               | `95d339631d867c8f1d15a5f2ec26069d` |
| `spec128.zip`               | `1a524bfa489cec90c941e6587d553a56` |
| `spec1282a.zip`             | `1c65f9cd31676facd7ccddc80f5cb83f` |
| `spectrum.zip`              | `4698414be3369fff17bf6d3111734c6c` |
| `syscard3.pce`              | `38179df8f4ac870017db21ebcbf53114` |
| `tos.img`                   | `c1c57ce48e8ee4135885cee9e63a68a2` |
| `uni-bioscd.rom`            | `08ca8b2dba6662e8024f9e789711c6fc` |
| `ym2608.zip`                | `79ae0d2bb1901b7e606b6dc339b79a97` |

## `BIOS/keropi/`

Used for _Sharp X68000_ emulation.

| File                  | MD5 Checksum                       |
|-----------------------|------------------------------------|
| `keropi/cgrom.dat`    | `cb0a5cfcf7247a7eab74bb2716260269` |
| `keropi/iplrom.dat`   | `7fd4caabac1d9169e289f0f7bbf71d8e` |
| `keropi/iplrom30.dat` | `f373003710ab4322642f527f567e020a` |
| `keropi/iplromco.dat` | `cc78d4f4900f622bd6de1aed7f52592f` |
| `keropi/iplromxv.dat` | `0617321daa182c3f3d6f41fd02fb3275` |

## `BIOS/np2/`

Used for _NEC PC-9800 (PC-98) series_ emulation.

| File               | MD5 Checksum                       |
|--------------------|------------------------------------|
| `np2/2608_BD.wav`  | `9c6637930b1779abe00b8b63e4e41f50` |
| `np2/2608_HH.wav`  | `73548a1391631ff54a1f7c838d67917e` |
| `np2/2608_RIM.wav` | `43d54b3e05c081fa280c9bace3af1043` |
| `np2/2608_SD.wav`  | `08124ccb84a9f65e2affc29581e690c9` |
| `np2/2608_TOM.wav` | `0faed5664a2dd8b1b2308e8a50ac25ea` |
| `np2/2608_TOP.wav` | `3721ace646ffd56439aebbb2154e9263` |
| `np2/FONT.ROM`     | `ca87908a99ea423093f6d497fc367f7d` |
| `np2/bios.rom`     | `50274bb5dcb707e4450011b09accffcb` |
| `np2/d8000.rom`    | `dc8e3222c6cfe24950a162467ad1a608` |
| `np2/font.bmp`     | `7da1e5b7c482d4108d22a5b09631d967` |
| `np2/itf.rom`      | `a13d96da03a28af8418d7f86ab951f1a` |
| `np2/sound.rom`    | `42c271f8b720e796a484cc1165ff4914` |

## `BIOS/xmil/`

Used for _Sharp X1_ emulation.

| File              | MD5 Checksum                       |
|-------------------|------------------------------------|
| `xmil/IPLROM.X1`  | `eeeea1cd29c6e0e8b094790ae969bfa7` |
| `xmil/IPLROM.X1T` | `851e4a5936f17d13f8c39a980cf00d77` |

[bios.md5]: https://github.com/skyzyx/rg35xx-garlicos-macos-instructions/raw/main/bios.md5
[Homebrew]: https://mac.install.guide/homebrew/index.html
