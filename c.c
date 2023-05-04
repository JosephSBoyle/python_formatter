#include <stdio.h>
#include <string.h>

void align_equals(char **lines, int num_lines) {
    int max_len = 0, num_vars = 0, i, j;

    // Count the number of variables and find the max length of variable names
    for (i = 0; i < num_lines; i++) {
        char *line = lines[i];
        char *equals = strchr(line, '=');
        if (equals != NULL) {
            num_vars++;
            int var_len = equals - line;
            if (var_len > max_len) {
                max_len = var_len;
            }
        }
    }

    // Pad variable names with spaces to align the equals signs
    for (i = 0; i < num_lines; i++) {
        char *line = lines[i];
        char *equals = strchr(line, '=');
        if (equals != NULL) {
            int var_len = equals - line;
            int num_spaces = max_len - var_len;
            char padded_line[1000] = "";
            strncat(padded_line, line, var_len + 1);
            for (j = 0; j < num_spaces; j++) {
                strcat(padded_line, " ");
            }
            strcat(padded_line, equals);
            strcat(padded_line, strchr(equals + 1, '\0'));
            strcpy(line, padded_line);
        }
    }
}

static void main() {
    char str[] = "a = \"foo\"\n"
                "bar = \"baz\"\n"
                "\n"
                "cart = \"horse\"\n"
                "def foobar(\n"
                "    xx=12,\n"
                "    y=9,   \n"
                "):\n"
                "    return (xx == y)\n";

    char aligned_str[] = align_equals(str, 30)
    printf("%s", aligned_str)
}