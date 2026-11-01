#!/bin/sh
# Records the 100x30 catalog preview, asciiverse/gearhead-arena.cast
# (hub/RECORDING.md): a new RPG campaign in Basic mode, the backstory, and
# a walk through the first town, played by asciiverse/drive.py for 45 s.
# asciinema records a tmux pane (own socket, no status line, no user
# config) that drive.py reads and plays in. Towns, characters and
# conversations are random, so takes differ.
# Needs asciinema 3 and tmux; run asciiverse/build.sh and stage.sh first.
set -eu
here=$(cd "$(dirname "$0")" && pwd)
root=$(dirname "$here")
out=$here/gearhead-arena.cast
home=$(mktemp -d)
trap 'tmux -L avrec kill-server 2>/dev/null; rm -rf "$home"' EXIT
cp -R "$root/stage" "$home/game"
cd "$home"  # nothing in the recording names a local path
unset XDG_CONFIG_HOME
export HOME="$home" PATH="$home/game:$PATH" TERM=xterm-256color COLORTERM=truecolor LANG=C.UTF-8
tmux -L avrec -f /dev/null new-session -d -s rec -x 100 -y 30 "gharena" \; set -g status off
python3 -I "$here/drive.py" avrec rec 45 2>/dev/null &
drive=$!
asciinema rec --headless --overwrite -q \
  --window-size 100x30 --idle-time-limit 2 \
  --capture-env "TERM,COLORTERM,LANG" --title "GearHead: Arena" \
  --command "tmux -L avrec attach -t rec" "$out" &
rec=$!
wait "$drive" || true
tmux -L avrec send-keys -t rec Up \; send-keys -t rec Enter   # Quit Game
wait "$rec"
