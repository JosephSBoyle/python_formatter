
#!/bin/bash

align_equals() {
    # Read lines from standard input into an array
    readarray -t lines

    formatted_lines=()
    i=0
    while [ $i -lt ${#lines[@]} ]; do
        # Group adjacent lines with variable assignments together
        group=()
        while [ $i -lt ${#lines[@]} ] && [[ ${lines[$i]} == *"="* ]] && [[ ${lines[$i]} != *"=="* ]]; do
            group+=("${lines[$i]}")
            ((i++))
        done
        if [ ${#group[@]} -gt 0 ]; then
            # Determine the maximum length of the variable name for this group
            max_length=0
            for line in "${group[@]}"; do
                var=$(echo "$line" | cut -d'=' -f1)
                var_length=${#var}
                if [ $var_length -gt $max_length ]; then
                    max_length=$var_length
                fi
            done

            # Align the equals signs for this group and add the formatted lines to the output
            for line in "${group[@]}"; do
                var=$(echo "$line" | cut -d'=' -f1)
                value=$(echo "$line" | cut -d'=' -f2- )
                prefix_spaces=$(echo "$var" | grep -o '^ *' | wc -c)
                space_padding=$((max_length - prefix_spaces))
                if [ $prefix_spaces -gt 0 ]; then
                    formatted_line="$(printf '%*s' $prefix_spaces)"
                    formatted_line+="$(printf "%-*s = %s" $((max_length)) "$var" "$value")"
                else
                    formatted_line=$(printf "%-*s=%s" $((max_length)) "$var" "$value")

                fi
                formatted_lines+=("$formatted_line")
            done
        else
            formatted_lines+=("${lines[$i]}")
            ((i++))
        fi
    done

    # Print formatted lines
    printf '%s\n' "${formatted_lines[@]}"
}

align_equals < test_input.py

