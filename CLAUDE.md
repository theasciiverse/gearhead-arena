# GearHead: Arena (Asciiverse packaging)

Joseph Hewitt's GearHead: Arena (Free Pascal, LGPL-3.0-or-later), the
first roguelike mecha RPG, packaged for the Asciiverse catalog (id
`gearhead-arena`, binary `gharena`) in its ASCII version, the way DRL is
packaged. Not our code: keep changes small and list every one in
PATCHES.md.

- `upstream` is github.com/jwvhewitt/gearhead-1 (branch `master`); ours is
  branch `asciiverse`, `origin` github.com/theasciiverse/gearhead-arena.
- Release: tag `v1.310+20240929-av.<n>` and push it;
  `.github/workflows/release.yml` builds Linux (static), macOS and
  .deb/.rpm/.apk/Arch packages. No Windows build.
- Build: `sh asciiverse/build.sh` (fpc 3.2.2), then `sh asciiverse/stage.sh`;
  run `stage/gharena`. The game reads its data from the current folder;
  settings and saves go to ~/.config/gharena.
- Preview: `asciiverse/record-preview.sh` (asciinema 3, tmux), about 40 s;
  towns are random. In the game, Esc (not q) closes the backstory and
  ends a conversation; NPCs start talking again while you stand beside
  them, so the driver steps away.
- GearHead 2 is packaged the same way in ../gearhead-2.
