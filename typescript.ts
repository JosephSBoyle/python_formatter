import * as fs from 'fs';

function alignEquals(lines: string[]): string[] {
    lines = lines.map((line) => line.trimEnd());
    const formattedLines: string[] = [];
    let i = 0;
    while (i < lines.length) {
      // Group adjacent lines with variable assignments together
      const group: string[] = [];
      while (i < lines.length && lines[i].includes("=") && !lines[i].includes("==")) {
        group.push(lines[i]);
        i++;
      }
      if (group.length) {
        // Determine the maximum length of the variable name for this group
        const maxVarLength = Math.max(...group.map((line) => line.split("=")[0].length));
        // Align the equals signs for this group and add the formatted lines to the output
        for (const line of group) {
          const [varName, value] = line.split("=");
          const prefixSpaces = varName.length - varName.trimStart().length;
          let formattedLine: string;
          if (prefixSpaces) {
            // Special handling for if the line starts with a space,
            // for instance in multi-line arguments.
            const spacePadding = maxVarLength - prefixSpaces;
            formattedLine = `${' '.repeat(prefixSpaces)}${varName.trim().padEnd(spacePadding)} = ${value.trim()}`
          } else {
            formattedLine = `${varName.trim().padEnd(maxVarLength, " ")}=${value}`;
          }
          formattedLines.push(formattedLine);
        }
      } else {
        formattedLines.push(lines[i]);
        i++;
      }
    }
    return formattedLines;
  }

const filePath = 'test_input.py';
const lines = fs.readFileSync(filePath, 'utf8').split('\n');

for (const line of alignEquals(lines)) {
  console.log(line);
}