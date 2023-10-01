#!/bin/bash

# Set the directory path where "hwdef.dat" files are located
target_folder="customTargets/"

# Regular expression to match a number (integer or float)
number_regex='^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)$'

# Loop through all environment variables starting with SECURE_
for var in $(env | grep '^SECURE_'); do
    # Get the variable name and value
    var_name_without_prefix=$(echo $var | cut -d= -f1 | sed 's/^SECURE_//')
    echo "Found Variable $var_name_without_prefix"
    var_value=$(echo $var | cut -d= -f2)
    if [[ $var_value =~ $number_regex ]]; then
        # Variable value is a number, no need to add quotes
        value_to_append="$var_value"
    else
        # Variable value is not a number, add double quotes
        value_to_append="\"$var_value\""
    fi

    value_to_append_escaped=$(echo "$value_to_append" | sed 's/"/\\\"/g')

    # Update each "hwdef.dat" file in the target folder
    find "$target_folder" -type f -name "hwdef.dat" -exec sh -c 'echo "#define $1 $2" >> "$0"' {} "$var_name" "$value_to_append_escaped" \;
done