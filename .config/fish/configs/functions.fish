# Find files by their name and print the relative path
function search
    find ./ -type f 2>/dev/null | grep -iF $argv
end

# Find files that contain some string
function searchin
    set search_term $argv[1]
    set window_width (tput cols)
    set cut_width (math "$window_width - 6")

    grep -rn --color=always "$search_term" . | while read -l line
        set file_path (echo $line | awk -F: '{print $1}')
        set line_number (echo $line | awk -F: '{print $2}')

        echo "$file_path:$line_number"

        set above_line (math "$line_number - 1")
        set above_content (sed -n "$above_line p" $file_path)
        if test -n "$above_content"
            set formatted_above_line (printf "%4s" $above_line)
            echo -e "\e[90m$formatted_above_line\e[0m $above_content" | cut -c1-$cut_width
        end

        set content (echo $line | cut -d':' -f3-)
        set formatted_line_number (printf "%4s" $line_number)
        echo -e "\e[90m$formatted_line_number\e[0m $content" | cut -c1-$cut_width

        set below_line (math "$line_number + 1")
        set below_content (sed -n "$below_line p" $file_path)
        if test -n "$below_content"
            set formatted_below_line (printf "%4s" $below_line)
            echo -e "\e[90m$formatted_below_line\e[0m $below_content" | cut -c1-$cut_width
        end

        echo -e "\e[0m"
    end
end
