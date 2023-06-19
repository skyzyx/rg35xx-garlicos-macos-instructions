#!/opt/homebrew/bin/bash
set -euo pipefail

##
# This file will perform an opinionated cleanup of mame-original.csv to produce
# mame-original.csv. It requires modern Bash, newer than what Apple ships
# (because of the GPLv3 license). Requires packages installed from Homebrew.
#
# We're going to use the GNU sed which comes from Homebrew, because it supports
# patterns that the BSD sed (that ships with macOS) does not.
##

# Ensure that dependencies are installed.
brew install bash coreutils gnu-sed

# Identify the files we're working with
source_file="$(pwd)/mame-original.csv"
dest_file="$(pwd)/mame.csv"

# Read the contents of the file into RAM
csv_content="$(cat "$source_file")"

#-------------------------------------------------------------------------------

##
# Broad strokes; blunt fixes
##

# Sort
csv_content="$(echo "$csv_content" | sort --ignore-case --human-numeric-sort)"

# Correct double-spaces to single-space
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's/\s+/ /g')"

# Remove anything in parentheses
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's/\s+\([^\)]*\)\)?//g')"

# Remove things that look like revisons/versions
#
# rev. 1.2
# Rev:1.1
# rev 3.1 29-column
# rev 2.4
# rev A
# Ver.Korea2
# V4.4.1
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's/\s+(rev|ver)(\.|\:)?\s*[a-z0-9\.\s-]*//gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's/\s+[0-9]+-column//gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's/\s+v[0-9\.]+//gi')"

# Replace [space][hyphen][space] with [colon][space]
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's/\s+-\s+/: /g')"

# Replace [space][colon][space] with [colon][space]
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's/\s+:\s+/: /g')"

# Replace [space][slash][space] with [slash]
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's/\s+\/\s+/\//g')"

# The abbreviation for versus should always be lowercase, even in a title, unless it is the first word
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's/\s+Vs\.\s+/ vs. /gi')"

# Installation dates
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|(\s+\|/)Install:\s[0-9]{1,2}/[0-9]{1,2}/[0-9]{1,2}||g')"

# Double-quotes as HTML entities
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|&quot;||g')"

# Some-in-1
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's/([0-9]+) in 1/\1-in-1/g')"

# References to MHz
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's/\s+[0-9\.]+MHz//g')"

# Abbreviate some words
csv_content="$(echo "$csv_content" | gsed 's/\bAnniversary\b/Anniv./g')"
csv_content="$(echo "$csv_content" | gsed 's/\bCommunication\b/Comm./g')"
csv_content="$(echo "$csv_content" | gsed 's/\bEdition\b/Ed./g')"
csv_content="$(echo "$csv_content" | gsed 's/\bFlexible\b/Flex./g')"
csv_content="$(echo "$csv_content" | gsed 's/H\.\Q./HQ/g')"
csv_content="$(echo "$csv_content" | gsed 's/\bProcessor\b/Proc./g')"
csv_content="$(echo "$csv_content" | gsed 's/\bProfessional\b/Pro/g')"
csv_content="$(echo "$csv_content" | gsed 's/\bSynthesizer\b/Synth/g')"

# Other appended things
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's/\s+\[BET\]//gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's/\s+\[TTL\]//gi')"

#-------------------------------------------------------------------------------

##
# Surgical cuts; specific fixes
# Prefers U.S. English over Japanese
#
# Need --regexp-extended if using:
# * non-slash characters as delimiters
# * match references as substitutions in the replacement
##

# Replace "slashed" names
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Alpha Mission II/ASO II: Last Guardian|Alpha Mission II: Last Guardian|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Animal Basket/Hustle Tamaire Kyousou*|Animal Basket|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|B.C. Kid/Bonk'\''s Adventure/Kyukyoku!! PC Genjin|B.C. Kid: Bonk'\''s Adventure|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Boomer Rang'\''r/Genesis|Boomer Rang'\''r|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Boulder Dash/Boulder Dash|Boulder Dash|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Brick People/Block PeePoo|Brick People|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Casino Strip Private Eyes/All Start|Casino Strip Private Eyes|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Choutetsu Brikin'\''ger/Iron Clad|Iron Clad|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Class of|c/o|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Crash '\''n Score/Stock Car|Crash '\''n Score: Stock Car|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|D-box 1, Kirsch gruppe|D-box 1|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Double Dance Mania: Supreme/Dance Supreme|Double Dance Mania: Supreme|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Dragon World 3.*|Dragon World 3|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Fight Fever/Wang Jung Wang|Fight Fever|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Final Fight/Final|Final Fight|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Fire Hawk/Huohu Chuanshuo|Fire Hawk|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Fist Of The North Star/Hokuto no Ken|Fist Of The North Star|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Football Champ/Euro Football Champ|Euro Football Champ|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Ganbare Jajamaru Saisho wa Goo/Ganbare Jajamaru Hop Step &amp; Jump|"Ganbare Jajamaru Hop, Step, \&amp; Jump"|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Golden Axe: The of Death Adder|Golden Axe: The Revenge of Death Adder|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Hidden Catch/Tul Lin Gu Lim Chat Ki|Hidden Catch|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|JX30GP, Motherboard P/N: 09-00189-10|"JX30GP, Motherboard P/N: 09-00189-10"|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Las Vegas, Nevada|"Las Vegas, Nevada"|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Mine, Mine, Mine|"Mine, Mine, Mine"|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|olds103t,Xiyou Shi E Chuan Super.*|olds103t,Oriental Legend Super|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Pacman Club/Club Lambada|Pacman Club|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Pae Wang Jeon Seol/|Samurai Showdown: |gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Photo Y2K 2/Chaoji Bi Yi Bi 2/Dajia Lai Zhao Cha 2/Real and Fake 2 Photo Y2K|Real and Fake 2: Photo Y2K|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Photo Y2K/Chaoji Bi Yi Bi/Dajia Lai Zhao Cha/Real and Fake|Photo Y2K: Real and Fake|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Playmaker: Hockey, Soccer, Basketball|"Playmaker: Hockey, Soccer, Basketball"|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Pro Sports: Bowling, Tennis, and Golf|"Pro Sports: Bowling, Tennis, and Golf"|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Seibu Cup Soccer :Selection:|Seibu Cup Soccer|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|The Gladiator/Shen Jian.*|The Gladiator|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|The Good, The Bad &amp; The Money|"The Good, The Bad, \&amp; The Money"|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|The Irritating Maze/Ultra Denryu Iraira Bou|The Irritating Maze|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|The King of Fighters '\''98: The Slugfest/King of Fighters '\''98: Dream Match Never Ends|The King of Fighters '\''98: The Slugfest|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|The King of Fighters: Fuchou Zhi Lu/Road to/The King of Fighters 2002 Unlimited Match|The King of Fighters 2002 Unlimited Match|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Touryuu Densetsu Elan-Doree/Elan Doree: Legend of Dragoon|Elan Doree: Legend of Dragoon|gi')"

# Strip prefixes/suffixes from a name
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's| \(CPU 0.04, display 0.10||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/(Shin )?Samurai Spirits.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Ao Jian Kuang Dao.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Art of Fighting: Ryuuko no Ken Gaiden.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Ashita no Joe Densetsu.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Bakudan Yarou.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Bakumatsu Roman.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Bakuretsu Crash Race.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Chou-Jikuu Yousai Macross.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Daraku Tenshi: The Fallen Angels.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Fu'\''un Super Tag Battle.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Galaxian Nave Creciente||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Game Tengoku: The Game Paradise||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Garou Densetsu.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Jin Saulabi Tu Hon.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Kunio no Nekketsu Toukyuu Densetsu||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Los Justicieros.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Magical Date:.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Miss Tang Ja Ru Gi.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Moero! Justice Gakuen.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Mohuan Xingzuo.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/New Dyna Blaster||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/New Tul Lin Gu Lim Chat Ki||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/NinjaKun Ashura no Shou.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Pao Pao Yu.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Real Bout Garou Densetsu.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Riku Kai Kuu Saizensen.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Ryuuko no Ken.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Sanguo Zhan Ji.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Sheng Mo Shiji||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Speed Buggy||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Stakes Winner:.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Tatsujin.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Tetris Dekaris.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Tokuten Ou.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Toretore! Sushi||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Tsuukai GANGAN Koushinkyoku.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Ultra Keibitai.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Unou Nouryoku Check Machine.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Xing Yi Quan.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Xiyou Shi E Chuan.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Yuke Yuke Yamaguchi-kun.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|/Zhuan Zhuan Puzzle.*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|\(M1A/B\).*||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Asian Dynamite/||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Block Carnival/Thunder|Block Carnival: Thunder|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Dynablaster/||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|E.D.F. : Earth Defense Force|Earth Defense Force|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|f3in1,3-in-1: Football, Basketball, Soccer|f3in1,"3-in-1: Football, Basketball, Soccer"|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Ganbare! Gonta!! 2/||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Journey/Raguy|Journey|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Ms\. Pacman Champion Ed\./.*|Ms. Pacman Champion Ed.|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Ninja-Kid II/NinjaKun Ashura no Shou|Ninja-Kid II|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Scud Race( Plus)?/||gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Street Smart/Final Fight|Final Fight|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Suiko Enbu/||gi')"

# Fix spellings
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's/beatmania/Beatmania/gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's/Pig'\''s &amp; Bomber'\''s/Pigs \&amp; Bombers/gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's/Samurai Shodown/Samurai Showdown/gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's/SetUp/Setup/gi')"

# U.S. English spelling
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's/(C)olour/\1olor/gi')"

# Old Apple computer names
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's/Apple \]\[/Apple II/gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Apple //(c\|e)|Apple II\1|gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's|Apple ///|Apple III|gi')"

# Other corrections
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's/Ampex ([0-9]+) plus/Ampex \1\+/gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's/asi100b0,ASI 100B0,.*/asi100b0,ASI 100B0/gi')"
csv_content="$(echo "$csv_content" | gsed --regexp-extended 's/bbredux,Bubble Bobble/bbredux,Bubble Bobble Redux/gi')"

#-------------------------------------------------------------------------------

# Write the updated contents back to disk in the destination file
# gtee will print the output to stdout and also write it to the file
echo "$csv_content" | gtee "$dest_file"
