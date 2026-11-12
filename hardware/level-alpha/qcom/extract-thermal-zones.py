"""Extract a SoC's thermal-zone definitions without changing their contents."""

import re
import sys
from pathlib import Path


def extract(source):
    match = re.search(r"(?m)^\s*thermal-zones\s*\{", source)
    if match is None:
        raise ValueError("SoC source has no thermal-zones node")
    start = source.index("thermal-zones", match.start())
    depth = 0
    # Braces inside comments and strings are not DTS structural delimiters.
    tokens = re.finditer(r'//[^\n]*|/\*.*?\*/|"(?:\\.|[^"\\])*"|[{}]', source[start:], re.S)
    for token in tokens:
        if token.group() == "{":
            depth += 1
        elif token.group() == "}":
            depth -= 1
            if depth == 0:
                end = start + token.end()
                semicolon = re.match(r"\s*;", source[end:])
                if semicolon is None:
                    raise ValueError("Unterminated thermal-zones node")
                return source[start:end + semicolon.end()] + "\n"
    raise ValueError("Unbalanced thermal-zones node")


if __name__ == "__main__":
    Path(sys.argv[2]).write_text(extract(Path(sys.argv[1]).read_text()))
