on run {input, parameters}
	if input is not {} then
		set targetFile to POSIX path of input
		tell application "System Events"
			tell application "WezTerm"
				do shell script "/opt/homebrew/bin/fish -c 'php ~/.config/wezterm/open-with-vim.php \"" & targetFile & "\"'"
			end tell
		end tell
	end if
end run

