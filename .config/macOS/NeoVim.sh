#!/bin/bash

if [[ -z "$1" ]]; then
    echo "Usage: $0 <file_path>"
    exit 1
fi

file_path="$1"

# Suche ein Pane mit nvim-Prozess
pane=$(/opt/homebrew/bin/tmux list-panes -a -F "#{session_name}:#{window_index}.#{pane_index}" | while read -r p; do
    pid=$(/opt/homebrew/bin/tmux list-panes -t "$p" -F "#{pane_pid}")
    if ps -o comm= --ppid "$pid" | grep -q nvim; then
        echo "$p"
        break
    fi
done)

if [[ -n "$pane" ]]; then
    for _ in {1..5}; do
        /opt/homebrew/bin/tmux send-keys -t "$pane" Escape
    done
    /opt/homebrew/bin/tmux send-keys -t "$pane" ":tabedit $file_path" Enter
    /opt/homebrew/bin/tmux select-window -t "$pane"
else
    current_path=$(/opt/homebrew/bin/tmux display-message -p -F "#{pane_current_path}")
    /opt/homebrew/bin/tmux new-window -c "$current_path" -n "nvim" "nvim \"$file_path\""
    new_window_index=$(/opt/homebrew/bin/tmux display-message -p -F "#{window_index}")
    /opt/homebrew/bin/tmux select-window -t "$new_window_index"
fi

exit 0
