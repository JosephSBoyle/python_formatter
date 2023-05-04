"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var fs = require("fs");
function alignEquals(lines) {
    lines = lines.map(function (line) { return line.trimEnd(); });
    var formattedLines = [];
    var i = 0;
    while (i < lines.length) {
        // Group adjacent lines with variable assignments together
        var group = [];
        while (i < lines.length && lines[i].includes("=") && !lines[i].includes("==")) {
            group.push(lines[i]);
            i++;
        }
        if (group.length) {
            // Determine the maximum length of the variable name for this group
            var maxVarLength = Math.max.apply(Math, group.map(function (line) { return line.split("=")[0].length; }));
            // Align the equals signs for this group and add the formatted lines to the output
            for (var _i = 0, group_1 = group; _i < group_1.length; _i++) {
                var line = group_1[_i];
                var _a = line.split("="), varName = _a[0], value = _a[1];
                var prefixSpaces = varName.length - varName.trimStart().length;
                var formattedLine = void 0;
                if (prefixSpaces) {
                    // Special handling for if the line starts with a space,
                    // for instance in multi-line arguments.
                    var spacePadding = maxVarLength - prefixSpaces;
                    formattedLine = "".concat(' '.repeat(prefixSpaces)).concat(varName.trim().padEnd(spacePadding), " = ").concat(value.trim());
                }
                else {
                    formattedLine = "".concat(varName.trim().padEnd(maxVarLength, " "), "=").concat(value);
                }
                formattedLines.push(formattedLine);
            }
        }
        else {
            formattedLines.push(lines[i]);
            i++;
        }
    }
    return formattedLines;
}
var filePath = 'test_input.py';
var lines = fs.readFileSync(filePath, 'utf8').split('\n');
for (var _i = 0, _a = alignEquals(lines); _i < _a.length; _i++) {
    var line = _a[_i];
    console.log(line);
}
