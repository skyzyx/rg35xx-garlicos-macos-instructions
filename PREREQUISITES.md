# Prerequisites

There are a few tutorials where you can either do things by hand, **OR** you can leverage scripts which perform the tasks in an automated way. If you **choose** to run the scripts by following directions, there are a few things to install on your Mac that will streamline everything.

**If you would prefer to do things by hand, you can skip this entire page.** I've tried to document everything by hand first, then I go back and automate the bits I can after the fact. **Said another way:** you will not be penalized by these tutorials if you choose not to leverage the automation I've written.

## Xcode CLI Tools

If you've ever been asked to install Xcode before, you may have just experienced a _cold sweat_. Xcode takes a long time to download, then takes something like 15.3 _weeks_ to decompress and complete installation.

However, this is NOT the _massive_, several GB download of Xcode from the App Store. This is _only_ the CLI tools, which is download of a _few hundred_ MBs. Not a big deal.

Rather than re-write great documentation, I'll point you over to <https://mac.install.guide/commandlinetools/1.html> instead. Go do that first, then come back.

## Homebrew

Welcome back! It's good to see you again. I've missed you. How's your family? That's good to hear. I'm so happy for you!

Next: **Homebrew** is a _package manager_ (think: App Store) for CLI tools. If you're familiar with:

* `yum`, `dnf`, `apt-get`, or `apk` in Linux…
* `choco` or `winget` in Windows…
* `npm` for Node.js…
* `composer` for PHP…
* `pip` or `poetry` for Python…

…it's pretty much the same concept. If you don't understand _any_ of what I'm talking about, no worries. Just trying to provide you a mental shortcut. Although in this day and age, I certainly hope you know what an **App Store** is.

Again, rather than re-write great documentation, I'll point you over to <https://mac.install.guide/homebrew/index.html> instead. Go do your thing. I'll be waiting here.

## Checking for a functioning Homebrew

At this point, you should have a working installation of Homebrew that you can run from your terminal app. If you run…

```bash
brew config
```

…you should see some output that looks _relatively_ like the following.

```plain
HOMEBREW_VERSION: 4.1.9
ORIGIN: https://github.com/Homebrew/brew
HEAD: b0985dabec8517ab5afda7cfee7d59f1da4ed6ce
Last commit: 5 days ago
Core tap JSON: 06 Sep 11:08 UTC
HOMEBREW_PREFIX: /opt/homebrew
HOMEBREW_BAT_THEME: Monokai Extended Bright
HOMEBREW_CASK_OPTS: []
HOMEBREW_DISPLAY: /private/tmp/com.apple.launchd.WdekfdqWnQ/org.xquartz:0
HOMEBREW_EDITOR: code -w
HOMEBREW_MAKE_JOBS: 10
Homebrew Ruby: 2.6.10 => /System/Library/Frameworks/Ruby.framework/Versions/2.6/usr/bin/ruby
CPU: 10-core 64-bit arm_firestorm_icestorm
Clang: 15.0.0 build 1500
Git: 2.42.0 => /opt/homebrew/bin/git
Curl: 8.1.2 => /usr/bin/curl
macOS: 14.0-arm64
CLT: 15.0.0.0.1.1692336968
Xcode: 15.0
Rosetta 2: false
```

> [!IMPORTANT]
> Obviously some of your _details_ will be different. We're simply looking for a functioning Homebrew installation, and want to ensure the output avoids words like `ERROR` or `THE BLACK DEATH IS UPON YOU`. If you see anything like that, _run for your life!_

## Installing packages from Homebrew

Still there? No black death? Good. _Whew!_ Let's look at a few things we should plan to install… and _why!_

If you want to learn more, read the section titled “Understanding BSD vs GNU” to give you a 30,000-foot view of the situation.

| Package     | Description                                                                                                                                                                                                                                        |
|-------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Python      | Python is a programming language that some of these scripts are written in. You don't need to _know_ Python, you just need to install it so that it can run the scripts.                                                                           |
| `bash`      | Bash is… well… let's say that we need it in order to run a few scripts that are written in a _different_ programming language. The version of Bash that macOS ships with is very old (because _reasons_). This will install an up-to-date version. |
| `coreutils` | These are the GNU/Linux versions of CLI tools that are known as the "core utilities". On the CLI and inside scripts, they will always be called using `g` as the first letter. (E.g., `rm` → `grm`; `xargs` → `gxargs`.)                           |
| `findutils` | These are the GNU/Linux versions of CLI tools that are known as the "find utilities". On the CLI and inside scripts, they will always be called using `g` as the first letter. (E.g., `find` → `gfind`.)                                           |
| `grep`      | This is the GNU/Linux version of a tool called `grep`, which is used for reading the contents of things and/or filtering results. On the CLI and inside scripts, it will be called by the name `ggrep`.                                            |
| `gnu-sed`   | This is the GNU/Linux version of a tool called `sed`, which is used for editing strings of text. On the CLI and inside scripts, it will be called by the name `gsed`.                                                                              |
| `gnu-tar`   | This is the GNU/Linux version of a tool called `tar`, which is used for bundling files together into an archive. On the CLI and inside scripts, it will be called by the name `gtar`.                                                              |
| `p7zip`     | This tool is used for _compressing_/_decompressing_ archives, and is commonly used alongside `tar`. It's compression is better than `zip`, `gz`, or `bz2`, and is equivalent to `xz`.                                                              |
| `xz`        | This tool is used for _compressing_/_decompressing_ archives, and is commonly used alongside `tar`. It's compression is better than `zip`, `gz`, or `bz2`, and is equivalent to `7z`.                                                              |

After ensuring that Homebrew is set-up, you can install all of these packages with the following terminal command:

```bash
brew install bash coreutils findutils grep gnu-sed gnu-tar p7zip python@3.11 xz
```

## Understanding BSD vs GNU

If you think about a family tree, you may have an _Uncle Mike_ or a _Great Aunt Ruth_. And their kids end up being your cousins… somehow… and maybe being "removed" some number of times.

Think of macOS and Linux as having descended from two sisters. Sometimes you can see the family resemblance, but each side can also be pretty different from the other side. In this case, the macOS CLI tools were descended from something called FreeBSD, and the Linux CLI tools were descended from something called GNU. (I'm aiming for high-level understanding here, not 100% accuracy. Don't `@` me.)

The CLI tools in macOS and Linux tend to look the same and more-or-less act the same, but there are some subtle (and not-so-subtle) differences between the two. Some of those differences make scripts harder to write and run, however it's possible to install the GNU/Linux flavor of CLI tools onto macOS. So that's what we'll do. It will help give everything a level playing field across the board.
