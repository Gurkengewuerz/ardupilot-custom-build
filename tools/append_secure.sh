#!/bin/bash

# Set the directory path where "hwdef.dat" files are located
target_folder="customTargets/"

# Loop through all environment variables starting with SECURE_
for var in $(env | grep '^SECURE_'); do
    # Get the variable name and value
    var_name_without_prefix=$(echo $var | cut -d= -f1 | sed 's/^SECURE_//')
    echo "Found Variable $var_name_without_prefix"
    var_value=$(echo $var | cut -d= -f2)
    if [[ $var_value == *" "* || -z $var_value ]]; then
        # Variable value is a string, add double quotes
        value_to_append="\"$var_value\""
    else
        # Variable value is not a string, no need to modify
        value_to_append="$var_value"
    fi

    value_to_append_escaped=$(echo "$value_to_append" | sed 's/"/\\\"/g')

    # Update each "hwdef.dat" file in the target folder
    find "$target_folder" -type f -name "hwdef.dat" -exec sh -c 'echo "#define $1 $2" >> "$0"' {} "$var_name" "$value_to_append_escaped" \;
done