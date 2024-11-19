#!/usr/bin/env bash

# Locate and delete tmux error files
locate "server exited unexpectedly" | while read -r file; do
        if [[ -f $file ]]; then
                echo "Removing: $file"
                rm "$file"
        else
                echo "Not a valid file: $file"
        fi
done
