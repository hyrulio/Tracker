#!/bin/bash
#File manager hotswap
OVERVIEW="baobab"
MAINVIEW="nemo"
# 1. What are you looking for
echo "What Folder/File do you want to find?"
read target
# 2. Find the "closest" folder to the root (the shallowest one)
#  Finds the first option in the list and uses that one
ENTRANCE=$(find ~ -iname "*$target*" -printf "%d %p\n" 2>/dev/null | sort -n | head -1 | cut -d' ' -f2-)
# 3. Check if anything was found
if [ -z "$ENTRANCE" ]; then
    echo "Could not find path for '$target'."
elif [ -d "$ENTRANCE" ]; then
    echo "Teleporting to Ring Chart..."
    $OVERVIEW "$ENTRANCE" >/dev/null 2>&1 &
    disown
    exit
elif [ -f "$ENTRANCE" ]; then
    echo "Teleporting to File Manager"
    $MAINVIEW "$(dirname "$ENTRANCE")" >/dev/null 2>&1 &
    disown
    exit
else
    echo "Results cannot be opened normally, maybe a broken symlink?"
    echo "You can try the P.U.R.G.E script to see if that fixes any problems"
    fi
fi
