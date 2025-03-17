#!/bin/bash

if [[ -z "$1" ]]; then
    echo "Usage: $0 <file_path>"
    exit 1
fi

file_path="$1"

pane=$(/opt/homebrew/bin/tmux list-panes -a -F "#{session_name}:#{window_index}.#{pane_index} #{pane_current_command}" | grep -m1 "nvim")

if [[ -n "$pane" ]]; then
    pane_id=$(echo "$pane" | awk '{print $1}')
    session_name=$(echo "$pane_id" | cut -d: -f1)
    window_index=$(echo "$pane_id" | cut -d: -f2 | cut -d. -f1)

    for _ in {1..5}; do
        /opt/homebrew/bin/tmux send-keys -t "$pane_id" Escape
    done

    /opt/homebrew/bin/tmux send-keys -t "$pane_id" ":e $file_path" Enter

    # Focus the tmux window where nvim is running
    /opt/homebrew/bin/tmux select-window -t "$session_name:$window_index"
else
    current_path=$(/opt/homebrew/bin/tmux display-message -p -F "#{pane_current_path}")
    /opt/homebrew/bin/tmux new-window -c "$current_path" -n "nvim" "nvim \"$file_path\""

    # Get the newly created window index
    new_window_index=$(/opt/homebrew/bin/tmux display-message -p -F "#{window_index}")

    # Focus the new tmux window
    /opt/homebrew/bin/tmux select-window -t "$new_window_index"
fi

exit 0
