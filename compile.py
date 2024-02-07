import subprocess, re

source_files = ["Arrays", "Conversions", "Function", "Math", "String", "Syntax-Replacements"]

with open('./src/Index.ls', 'w') as file: file.write('\n'.join([open(f"./src/{filename}.ls", 'r').read() for filename in source_files]))

subprocess.run(['lsc', '-c' ,'./src/Index.ls'])

ENTRYPOINT_BLUEPRINT: str = """
import { Vec } from "./src/Vec";
const lib = require("./src/Index.js");

export { Vec };
export const { @FUNCTIONS } = lib;
"""

function_names_with_lispy_syntax: [str] = list(re.compile(r'export\s+(\w+)\s+=').findall(str(open("./src/Index.ls", 'r').read())))
function_names: [str] = list(map(lambda s: ''.join(word.capitalize() for word in s.split("-")) if "-" in s else s, function_names_with_lispy_syntax))

with open('./Index.ts', 'w') as file: file.write(ENTRYPOINT_BLUEPRINT.replace('@FUNCTIONS', ', '.join(function_names)))

subprocess.run(['ts-node', 'beautify'])

subprocess.run(['tsc', 'Index'])
