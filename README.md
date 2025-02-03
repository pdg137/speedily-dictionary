## Current version: v2.0.0

Words: 253,907

Sources:
* [SCOWL wamerican.90 and wbritich.90 dictionaries](http://wordlist.aspell.net/) (also known as wamerican-huge and wbritish-huge)
* [contributors](contrib/)

## Building

1. Install [nix](https://nixos.org/)
2. Run `nix-build -o dictionary.csv`
3. The dictionary will be built, tests will run, and if all is well the output will be left linked in this folder.

## Installation

1. Locate the folder where Speedily is installed, which should be `C:\Users\<username>\AppData\Local\Programs\Speedily`.
2. Find the file dictionary.csv in this folder.
3. Right-click and rename it to `dictionary-original.csv`, or something like `dictionary-v1.0.0.csv` if you already had a modified version.
4. Download the new dictionary.csv and move it into the Speedily folder.

## How can I tell that I'm on the latest release?

These words should work:

* atomise
* theorise
* plat

These words should not work:

* ohio
* emmy
* preace
