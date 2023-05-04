def align_equals(lines)
    lines = lines.map(&:rstrip)
    formatted_lines = []
    i = 0
    while i < lines.length
      # Group adjacent lines with variable assignments together
      group = []
      while i < lines.length && lines[i].include?("=") && !lines[i].include?("==")
        group << lines[i]
        i += 1
      end
      if group.length > 0
        # Determine the maximum length of the variable name for this group
        max_length = group.map { |line| line.split("=").first.length }.max
        # Align the equals signs for this group and add the formatted lines to the output
        group.each do |line|
          var, value = line.split("=", 2)
          if prefix_spaces = var.length - var.lstrip.length
            # Special handling for if the line starts with a space,
            # for instance in multi-line arguments.
            space_padding = max_length - prefix_spaces

            formatted_line = "#{' '*prefix_spaces}#{var.strip.ljust(space_padding)} = #{value.strip}"
            # formatted_line = "#{' '*prefix_spaces}#{var.strip}#{' ' * space_padding} = #{value.strip}"
          else
            formatted_line = "#{var.strip.ljust(max_length)} = #{value.strip}"
          end
  
          formatted_lines << formatted_line
        end
      else
        formatted_lines << lines[i]
        i += 1
      end
    end
    return formatted_lines
  end
  

lines = File.readlines("test_input.py", chomp: true)
puts align_equals(lines)