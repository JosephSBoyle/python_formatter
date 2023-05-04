def align_equals(lines: list[str]) -> list[str]:
    """
    Formats a list of strings of lines such that equals signs in variable assignments are aligned.

    Args:
        lines (list[str]): A list of strings representing lines of code.

    Returns:
        list[str]: A new list of strings representing the formatted lines of code.

    Example:
        >>> lines = [
        ...     'a = "foo"',
        ...     'bar = "baz"',
        ...     '',
        ...     'cart = "horse"',
        ...     'def foobar(',
        ...     '    xx=12,',
        ...     '    y=9,',
        ...     '):',
        ...     '    return (xx == y)',
        ... ]
        >>> formatted_lines = align_equals(lines)
        >>> print('\n'.join(formatted_lines))
        a    = "foo"
        bar  = "baz"
        
        cart = "horse"
        def foobar(
            xx=12,
            y =9,
        ):
            return (xx == y)
    """
    lines = [line.rstrip() for line in lines]
    formatted_lines = []
    i = 0
    while i < len(lines):
        # Group adjacent lines with variable assignments together
        group = []
        while i < len(lines) and '=' in lines[i] and '==' not in lines[i]:
            group.append(lines[i])
            i += 1
        if group:
            # Determine the maximum length of the variable name for this group
            max_length = max(len(line.split('=', 1)[0]) for line in group)
            # Align the equals signs for this group and add the formatted lines to the output

            for line in group:
                var, value = line.split('=', 1)
                if prefix_spaces := len(var) - len(var.lstrip(" ")):
                    # Special handling for if the line starts with a space,
                    # for instance in multi-line arguments.
                    space_padding = max_length - prefix_spaces
                    formatted_line = f"{' '*prefix_spaces}{var.strip():<{space_padding}} = {value.strip()}"
                else:
                    formatted_line = f"{var.strip():<{max_length - 1}} = {value.strip()}"
                
                formatted_lines.append(formatted_line)
        else:
            formatted_lines.append(lines[i])
            i += 1
    return formatted_lines



if __name__ == "__main__":
    lines = open("test_input.py", "r").readlines()
    
    for line in align_equals(lines):
        print(line)
