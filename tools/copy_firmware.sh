#!/bin/bash

set -e
set -x

dest_dir="${1}"
src_dir="ardupilot/build/"

rm -rf $dest_dir
mkdir -p $dest_dir

find "$src_dir" -type f -name "*.hex" -print0 | while IFS= read -r -d $'\0' file; do
    # Extract parent directory name
    parent_dir=$(dirname "$file")
    parent_dir_name=$(basename "$parent_dir")

    # Create destination directory
    dest_subdir="$dest_dir/$parent_dir_name"
    mkdir -p "$dest_subdir"

    # Copy the file to the destination directory
    cp "$file" "$dest_subdir/$(basename "$file")"
done