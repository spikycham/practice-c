#!/bin/bash

# The first line is called Shebang. It guarantees bash run the shell scripts, the default shell of some systems are not the bash, and the syntax may not be compatible.

# Stop the script when it meets any error command.
set -e
# Register handler for EXIT signal to remove the output file as long as the script exits.
trap "rm -f /tmp/crun.out" EXIT

file=$1

[ $# -eq 1 ] || { echo "[C_RUN] usage: $0 <filename>.c" >&2; exit 1; }
[ -f "$file" ] || { echo "[C_RUN] file not exists" >&2; exit 1; }
file -b "$file" | grep -q "c program" || { echo "[C_RUN] not c file" >&2; exit 1; }

gcc "$file" -o /tmp/crun.out
/tmp/crun.out

