## CS 513 Datat Cleaning Project - Summer 2025
## Benjamin Fridkis, Samarth Patel, Kesavar Kabilar
#### Script to convert MenuItem data from csv format to datalog entries

import os 
script_directory = os.path.dirname(os.path.abspath(__file__))

outputFile = f"{script_directory}\\MenuItem.lp"
#Clear output file if it exists, or create it if not
try:
    os.remove(outputFile)
except OSError:
    pass

# Re-combine split and cleaned MenuItem data. (Modify paths as needed.)
inputFile = f"{script_directory}\\MenuItem.csv"
with open(outputFile, 'w') as outfile:
    line_num = 0
    with open(inputFile) as infile:
        for line in infile:
            if line_num != 0:
                a = outfile.write(f"MenuItem({line.rstrip()}).\n")
            line_num += 1