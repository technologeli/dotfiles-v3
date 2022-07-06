#!/bin/python3
def parse_hex_code(hex_code: str):
    # strip hashtag
    if hex_code[0] == '#':
        hex_code = hex_code[1:]

    # split into twos and convert to decimal
    rgb = [ int(hex_code[i:i+2], 16) for i in range(0, 6, 2) ]
    return rgb

if __name__ == '__main__':
    while True:
        hex_code = input("Input hex code: ")
        rgb = parse_hex_code(hex_code)
        print(f"{hex_code} -> {rgb}")
