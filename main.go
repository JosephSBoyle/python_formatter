package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

// func formatLines(lines []string) []string {
// 	maxIndex := -1
// 	for _, line := range lines {
// 		index := strings.Index(line, "=")
// 		if index > maxIndex {
// 			maxIndex = index
// 		}
// 	}

// 	formattedLines := make([]string, len(lines))
// 	for i, line := range lines {
// 		index := strings.Index(line, "=")
// 		if index == -1 {
// 			formattedLines[i] = line
// 		} else {
// 			formattedLines[i] = strings.Replace(line, "=", strings.Repeat(" ", maxIndex-index)+"=", 1)
// 		}
// 	}

// 	return formattedLines
// }

// func formatLines(lines []string) []string {
// 	maxIndex := -1
// 	var prevIndex int

// 	formattedLines := make([]string, len(lines))
// 	for i, line := range lines {
// 		if len(strings.TrimSpace(line)) == 0 {
// 			maxIndex = -1 // reset maxIndex for empty lines
// 			formattedLines[i] = line
// 			continue
// 		}
// 		index := strings.Index(line, "=")
// 		if index == -1 {
// 			continue
// 		}

// 		if index > maxIndex {
// 			maxIndex = index
// 		}
// 		prevIndex = index
// 		formattedLines[i] = strings.Replace(line, "=", strings.Repeat(" ", maxIndex-index)+"=", 1)
// 	}
// 	return formattedLines
// }

func alignEquals(lines []string) []string {
	formattedLines := []string{}
	i := 0
	for i < len(lines) {
		// Group adjacent lines with variable assignments together
		group := []string{}
		for i < len(lines) && strings.Contains(lines[i], "=") && !strings.Contains(lines[i], "==") {
			group = append(group, lines[i])
			i++
		}
		if len(group) > 0 {
			// Determine the maximum length of the variable name for this group
			maxLength := 0
			for _, line := range group {
				parts := strings.SplitN(line, "=", 2)
				varName := strings.TrimSpace(parts[0])
				length := len(varName)
				if length > maxLength {
					maxLength = length
				}
			}
			// Align the equals signs for this group and add the formatted lines to the output
			for _, line := range group {
				parts := strings.SplitN(line, "=", 2)
				varName := strings.TrimSpace(parts[0])
				value := strings.TrimSpace(parts[1])

				if prefixSpaces := len(parts[0]) - len(strings.TrimLeft(parts[0], " ")); prefixSpaces > 0 {
					// Special handling for if the line starts with a space,
					// for instance in multi-line arguments.
					spacePadding := prefixSpaces - maxLength
					fmt.Println(spacePadding)
					formattedLine := fmt.Sprintf(
						"%s%-*s = %s",
						strings.Repeat(" ", prefixSpaces),
						spacePadding,
						strings.TrimSpace(varName),
						strings.TrimSpace(value),
					)
					formattedLines = append(formattedLines, formattedLine)
				} else {
					formattedLine := fmt.Sprintf("%-*s = %s", maxLength, varName, value)
					formattedLines = append(formattedLines, formattedLine)
				}
			}
		} else {
			formattedLines = append(formattedLines, lines[i])
			i++
		}
	}
	return formattedLines
}

func main() {
	// Open the file for reading
	file, err := os.Open("test_input.py")
	if err != nil {
		fmt.Println("Error opening file:", err)
		return
	}
	defer file.Close()

	// Create a scanner to read the file
	scanner := bufio.NewScanner(file)

	// Use a loop to read each line
	var lines []string
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}

	if err := scanner.Err(); err != nil {
		fmt.Println("Error scanning file:", err)
		return
	}

	for _, l := range alignEquals(lines) {
		fmt.Println(l)
	}
}
