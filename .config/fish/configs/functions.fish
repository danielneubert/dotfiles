function search
    # if argv is empry or -h or --help
    if test -z "$argv" -o "$argv" = "-h" -o "$argv" = "--help"
        echo "Usage: search [-f] <query>"
        echo "Search for file content containting the query."
        echo ""
        echo "Options:"
        echo "  -f  Search for files containing the query."
        return
    end

    // DEBUG: ERR while parse fs3
    set ignore_dirs ".git" "node_modules" "vendor"

    if test "$argv[1]" = "-f"
        find . -type f 2>/dev/null | grep -iF "$argv[2]" | sort | while read -l path
            set found false
            for substring in $ignore_dirs
                if string match -q "*$substring*" $path
                    set found true
                    break
                end
            end

            # if not fourd
            if not $found
                set before (string join " " (string split -- $argv[2] $path)[1..-2])
                set after (string join " " (string split -- $argv[2] $path)[2..-1])
                printf "\e[0m%s\e[100m\e[31m%s\e[0m%s\n" $before $argv[2] $after
            end
        end
        return
    end

    function echo_file_line
        set query $argv[1]
        set file $argv[2]
        set line $argv[3]
        set width $argv[4]

        # Get the line content from the file
        set content (sed -n "$line p" $file)

        if test -n "$content"
            if test $query = "-1"
                printf "\e[90m%4s \e[37m%s\e[0m\n" $line $content | string sub -l $width
            else
                set before (string join " " (string split -- $query $content)[1..-2])
                set after (string join " " (string split -- $query $content)[2..-1])
                printf "\e[37m%4s\e[0m %s\e[100m\e[31m%s\e[0m%s\e[0m\e[0m\n" $line $before $query $after | string sub -l $width
            end
        end
    end

    set query $argv[1]
    set window_width (tput cols)
    set width (math "$window_width - 6")

    set current_file ""
    set current_line 0

    # Ensure grep outputs are correctly read, without stripping ANSI codes
    grep -rn "$query" . | while read -l line
        set found false
        for substring in $ignore_dirs
            if string match -q "*$substring*" $line
                set found true
                break
            end
        end

        # if not fourd
        if not $found
            set path (echo $line | awk -F: '{print $1}')
            set line (echo $line | awk -F: '{print $2}')

            set chunks (string split "/" $path)
            set file (echo $chunks[-1])
            set chunks $chunks[1..-2]
            set folder (echo $chunks[-1])
            set parent (string join "/" $chunks[1..-2])

            # Only print the filename and line number once per file
            if test "$path" != "$current_file"
                if test "$current_file" != ""
                    echo_file_line "-1" $current_file (math "$current_line + 1") $width
                    echo ""
                end

                set current_line 0
                set current_file $path
                printf "\e[90m%s/\e[37m%s/\e[0m\e[4m%s\e[0m\n" $parent $folder $file
            end

            if test $current_line = "0"
                echo_file_line "-1" $path (math "$line - 1") $width
            else if test $line != (math "$current_line + 1")
                echo_file_line "-1" $path (math "$current_line + 1") $width
                if test (math "$current_line + 2") -lt $line
                    printf "\e[90m     ...\e[0m\n"
                    echo_file_line "-1" $path (math "$line - 1") $width
                end
            end

            echo_file_line $query $path $line $width

            set current_line $line
        end
    end

    if test "$current_file" != ""
        echo_file_line "-1" $current_file (math "$current_line + 1") $width
    end

    functions --erase echo_file_line
end


# Archive a web project
function web-archive --description "Clean node_modules, bring down Docker services, remove Docker images, and optionally archive the directory"
    # Remove node_modules directories recursively
    for dir in (find . -type d -name "node_modules")
        echo "Removing $dir"
        rm -rf $dir
    end

    # Check for docker-compose.yml or compose.yml in the current directory
    if test -f docker-compose.yml -o -f compose.yml
        # Load the .env file if it exists to get DOCKER_PROJECT
        if test -f .env
            echo "Loading environment variables from .env"

            for line in (cat .env | grep -v '^#' | grep -E '^[A-Za-z_][A-Za-z0-9_]*=')
                set key (echo $line | cut -d '=' -f 1)
                set value (echo $line | cut -d '=' -f 2-)
                set -x $key $value
            end
        end

        # Bring down Docker Compose services
        echo "Found docker-compose.yml or compose.yml. Running docker compose down."
        docker compose down

        # Extract Docker image names from the compose file
        for image in (grep -E 'image: ' docker-compose.yml compose.yml 2>/dev/null | awk '{print $2}')
            # Replace any variables like ${DOCKER_PROJECT}
            set image_name (echo $image | sed 's/\${\(.*\)}/(env $1)/')

            # Check if the image exists and remove it
            if docker images -q $image_name > /dev/null
                echo "Removing Docker image: $image_name"
                docker rmi $image_name
            end
        end

        # Check if the vendor directory exists in the root and remove it
        if test -d ./vendor
            echo "Removing vendor directory"
            rm -rf ./vendor
        end
    else
        echo "No docker-compose.yml or compose.yml found. Skipping Docker cleanup."
    end

    # Ask if the user wants to archive the directory
    echo ""
    echo "Do you want to archive the current directory? (Y/n): "
    read answer

    # Default to "yes" if no answer is provided
    if test -z "$answer" -o "$answer" = "y" -o "$answer" = "Y"
        if test ! -d ../_archive
            mkdir ../_archive
        end

        set archive_name ../_archive/(basename (pwd)).7z

        set dir_to_archive (pwd)
        if test (count $argv) -gt 0
            set dir_to_archive $argv[1]
        end

        echo "Archiving $dir_to_archive into $archive_name..."

        7zz a $archive_name $dir_to_archive

        if test -f $archive_name
            echo "Archive created: $archive_name"

            # Ask if the user wants to remove the directory after archiving
            echo ""
            echo "Do you want to remove the project directory and only keep the archive? (Y/n): "
            read remove_answer

            if test -z "$remove_answer" -o "$remove_answer" = "y" -o "$remove_answer" = "Y"
                echo "Removing $dir_to_archive"
                rm -rf $dir_to_archive
                cd ..
            else
                echo "Project directory wasn't removed."
            end
        else
            echo "Archive wasn't created."
        end
    else
        echo "Archive operation skipped."
    end
end
