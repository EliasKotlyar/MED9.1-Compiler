import json
import os
import sys


class ExtractMemoryMap:

    def __init__(self, filename):
        self.filename = filename

    def read_text_file(self, filename: str) -> str:
        try:
            with open(filename, 'r', encoding='utf-8') as file:
                content = file.read()
                return content
        except FileNotFoundError:
            raise FileNotFoundError(f"Error: File '{filename}' not found.")
        except Exception as e:
            raise Exception(f"Error reading file '{filename}': {e}")

    def process_file(self):
        text = self.read_text_file(self.filename)
        jsonstr = self.parse_readelf_output(text)
        jsonstr = json.dumps(jsonstr, indent=2)
        print(jsonstr)

    def parse_readelf_output(self, readelf_output: str):
        symbol_table = {}
        lines = readelf_output.strip().split("\n")
        for line in lines[3:]:
            line_parts = line.strip().split()
            if len(line_parts) >= 8:
                address = line_parts[1]
                size = line_parts[2]
                symbol_type = line_parts[3]
                bind = line_parts[4]
                vis = line_parts[5]
                section_index = line_parts[6]
                name = line_parts[7]

                symbol = {
                    "address": address,
                    "size": size,
                    "type": symbol_type,
                    "bind": bind,
                    "visibility": vis,
                    "section_index": section_index,
                    "name": name
                }
                forbidden_symbols = ["__SBSS2_END__", "__SBSS2_START__", "__SDATA2_END__", "__SDATA2_START__",
                                     "_SDA2_BASE_", "", "header", "footer"]
                if name in forbidden_symbols:
                    continue
                if symbol_type == "OBJECT":
                    type = "VAR_"
                elif symbol_type == "FUNC":
                    type = "FUNC_"
                else:
                    continue
                address_int = int(symbol["address"], 16)
                address_int = address_int - 0x40000000
                address = hex(address_int)
                key = type + symbol["name"]
                symbol_table[key] = address

        return symbol_table


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <filename>")
    else:
        filename = sys.argv[1]
        file_processor = ExtractMemoryMap(filename)
        file_processor.process_file()
