<?php

$command = 'tmux list-panes -a -F "#{session_name}:#{window_index}.#{pane_index} #{pane_current_command}" | grep nvim | tail -n 1';

$command2 = 'tmux send-keys -t "';
$command3 = '" Escape Escape ":Mason" Enter;';

function tmux($cmd): string
{
    return shell_exec("/opt/homebrew/bin/fish -c 'tmux {$cmd}'");
}

$result = tmux('list-panes -a -F "#{session_name}:#{window_index}.#{pane_index} #{pane_current_command}" | grep nvim | tail -n 1');
$result = explode(" ", $result, 2)[0];

tmux('send-keys -t Escape;');
tmux('send-keys -t Escape;');
tmux('send-keys -t Escape;');

file_put_contents(__DIR__ . '/demo.txt', "{$command2}{$result}{$command3}");
shell_exec("/opt/homebrew/bin/fish -c '{$command2}{$result}{$command3}'");

exit;
