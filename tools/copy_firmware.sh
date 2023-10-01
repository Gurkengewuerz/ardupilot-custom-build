#!/bin/bash

set -e
set -x

dest_dir="${1}"
src_dir="build/"

rm -rf $dest_dir
mkdir -p $dest_dir

cp_file () {
    # Extract parent directory name
    parent_dir=$(dirname "$1")
    grantparent_dir=$(dirname "$parent_dir")
    target_name=$(basename "$grantparent_dir")

    # Create destination directory
    dest_subdir="$dest_dir/$target_name"
    mkdir -p "$dest_subdir"

    # Copy the file to the destination directory
    cp "$file" "$dest_subdir/$(basename "$file")"
}

find "$src_dir" -type f -name "*.hex" -print0 | while IFS= read -r -d $'\0' file; do
    cp_file $file
done

find "$src_dir" -type f -name "*.apj" -print0 | while IFS= read -r -d $'\0' file; do
    cp_file $file
done
