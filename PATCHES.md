# Changes from upstream

This is the Asciiverse packaging of [GearHead: Arena](https://github.com/jwvhewitt/gearhead-1)
by Joseph Hewitt, the first roguelike mecha RPG (2005), in Free Pascal.
Upstream is the `upstream` remote; this build is upstream's `master` at
`df7b603` (2024-09-29), 1.310 plus later fixes, in its ASCII version
(no SDL). LGPL-3.0-or-later (`license.txt`). The `asciiverse` branch
carries the changes below.

## Code

- **Settings folder.** The game makes its settings and save folder,
  ~/.config/gharena, with MkDir, one level only: when ~/.config did not
  exist yet it stopped at start with "EInOutError: File not found". It
  now uses ForceDirectories, which makes the parents too.

## Packaging (new files)

- `asciiverse/build.sh`: `fpc gharena.pas`, the ASCII version. Free
  Pascal links the Linux binary fully static (its own runtime, no libc).
- `asciiverse/gharena`, `asciiverse/stage.sh`: av's start script and the
  archive layout. The game reads GameData, Series, Design and doc from the
  current folder, so the start script changes into `lib/`; settings and
  saves stay in the player's ~/.config/gharena as upstream has it.
  `Image/` is left out: only the SDL version uses it.
- `asciiverse/nfpm.yaml`: .deb, .rpm, .apk and Arch packages named
  `gearhead-arena`, installed in /usr/lib/gharena.
- `asciiverse/record-preview.sh`, `asciiverse/drive.py`: the catalog
  preview, played by a script in a tmux pane.
- `.github/workflows/release.yml`: builds all of it on a tag.

## Not built

- Windows, and the SDL (graphical) version.
