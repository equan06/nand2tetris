import argparse
import os
import sys
import re


symbols = {
    'SP': 0,
    'LCL': 1,
    'ARG': 2,
    'THIS': 3,
    'THAT': 4,
    'SCREEN': 16384,
    'KBD': 24576
}

def load_asm_from_path():
    "Load a .asm file and return a list of code-only lines."
    parser = argparse.ArgumentParser(description="Convert assembly into machine code readable by the Hack computer.")
    parser.add_argument('Path', metavar='path', type=str, help="the path to a .asm file")
    path = parser.parse_args().Path

    if not os.path.exists(path):
        print("The file specified does not exist")
        sys.exit()
    elif path[-3:] != 'asm':
        print("The specified file format was invalid (did you select a .asm file?)")
        sys.exit()
    
    with open(path) as asm:
        return [line for line in asm.read().splitlines() if not line.startswith('//') and line != '']

def add_symbols(asm):
    "Add all symbols to the symbols table of addresses."
    next_addr, ROM_SIZE = 16, 32768 
    for i in range(next_addr):
        symbols[f'R{i}'] = i
   
    curr_addr = 0
    for line in asm:
        if curr_addr < ROM_SIZE and line.startswith('('):
            symbol = re.search(r'[\w\d_.$:]+', line).group(0)
            if symbol not in symbols:
                symbols[symbol] = curr_addr
            else:
                raise Error(f"Duplicate symbol: {symbol}")
        else:
            curr_addr += 1

def convert_to_binary(line):
    "Convert a line of assembly to a 16 bit string."
    # if line[0] == '@':
    #     re.match(r'@')



if __name__ == '__main__':
    asm = load_asm_from_path()
    add_symbols(asm)
    # map(convert_to_binary, asm)