on run {input, parameters}
    if input is not {} then
        set targetFile to POSIX path of input

        tell application "System Events"
            -- Check if Ghostty is running
            set ghosttyRunning to (count (every process whose name is "Ghostty")) > 0
        end tell

        -- Start Ghostty if it's not running
        if not ghosttyRunning then
            tell application "Ghostty" to activate
            delay 3 -- Give it a moment to launch
            display dialog "Ghostty launched. Waiting for it to fully start..." buttons {"OK"} default button "OK"
        end if

        -- Ensure Ghostty is focused
        tell application "Ghostty" to activate

        -- Run the shell script
        set shellOutput to do shell script "/bin/sh -c \"$HOME/.dotfiles/.config/macOS/NeoVim.sh " & quoted form of targetFile & "\" 2>&1"
    end if
end run
