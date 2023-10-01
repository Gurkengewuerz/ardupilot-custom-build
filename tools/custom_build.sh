#!/bin/bash

set -e
set -x

rm -rf $BUILDROOT

path="../customTargets"

for dir in "$path"/*/; do
    # Extract directory name without the path
    dir_name=$(basename "$dir")
    
    # Exclude . and ..
    if [ "$dir_name" != "." ] && [ "$dir_name" != ".." ]; then
        echo "Processing directory: $dir_name"

        echo "Testing $dir_name build"
        ./waf configure --board $dir_name
        ./waf
    fi
done

exit 0
