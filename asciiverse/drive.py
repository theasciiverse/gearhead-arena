#!/usr/bin/env python3
"""drive.py SOCKET SESSION SECONDS: plays the start of GearHead: Arena in a
tmux pane. Start RPG Campaign, Basic mode, a name typed in, a few seconds
of the backstory (closed with Esc), then out into the first town: it ends any conversation
with Esc, steps away, and walks the streets with the arrow keys, in a seeded pattern,
until SECONDS have passed, then saves with Q, which goes back to the
main menu (record-preview.sh picks Quit Game there).
Run by record-preview.sh while asciinema records the pane."""
import random, subprocess, sys, time

SOCK, S, SECONDS = sys.argv[1], sys.argv[2], float(sys.argv[3])
rng = random.Random(5)

def tmux(*a): return subprocess.run(["tmux", "-L", SOCK, *a], capture_output=True, text=True).stdout
def key(*k): tmux("send-keys", "-t", S, *k)
def screen(): return tmux("capture-pane", "-p", "-t", S)

def wait_for(text, timeout=10):
    end = time.time() + timeout
    while time.time() < end:
        if text in screen():
            return True
        time.sleep(0.2)
    return False

start = time.time()
wait_for("Start RPG Campaign")
time.sleep(2.0); key("Enter")                      # Start RPG Campaign
wait_for("Select Mode"); time.sleep(1.5); key("Enter")   # Basic Mode
time.sleep(1.5); key("Enter")                      # gender
time.sleep(2.0)
for c in "Rook":
    key("-l", c); time.sleep(0.25)
time.sleep(0.6); key("Enter")
wait_for("[Q] or [ESC] to exit"); time.sleep(5.0); key("Escape")
time.sleep(2.0)

dirs = ["Up", "Down", "Left", "Right"]
d = rng.choice(dirs)
while time.time() - start < SECONDS:
    s = screen()
    if "[Goodbye]" in s or "[Chat]" in s:
        # leave with Esc, then walk away before the NPC starts again
        time.sleep(3.0); key("Escape"); time.sleep(1.0)
        if "[Goodbye]" not in screen():
            d = rng.choice(dirs)
            for _ in range(4):
                key(d); time.sleep(0.3)
        continue
    if rng.random() < 0.2:
        d = rng.choice(dirs)
    key(d)
    time.sleep(0.35)
key("Q")
time.sleep(1.5)
print(screen(), file=sys.stderr)
