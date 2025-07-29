## CS 513 Datat Cleaning Project - Summer 2025
## Benjamin Fridkis, Samarth Patel, Kesavar Kabilar
#### Script to re-combine split MenuItem csv files after cleaning (as initial dataset is too large for OpenRefine processing)

import os 

outputFile = "C:\\Users\\Annjamin\\Documents\\Benj's Stuff\\UIUC MCS\\CS513-TheoryAndPracticeOfDataCleaning\\Project\\Data Cleaning\\MenuItem\\MenuItem_clean.csv"
#Clear output file if it exists, or create it if not
try:
    os.remove(outputFile)
except OSError:
    pass

# Re-combine split and cleaned MenuItem data. (Modify paths as needed.)
filenames = [f"C:\\Users\\Annjamin\\Documents\\Benj's Stuff\\UIUC MCS\\CS513-TheoryAndPracticeOfDataCleaning\\Project\\Data Cleaning\\MenuItem\\MenuItem_{x}-CleanedwOpenRefine.csv" for x in range(1,7)]
with open(outputFile, 'a') as outfile:
    for fname in filenames:
        with open(fname) as infile:
            line_num = 0
            for line in infile:
                if fname == "C:\\Users\\Annjamin\\Documents\\Benj's Stuff\\UIUC MCS\\CS513-TheoryAndPracticeOfDataCleaning\\Project\\Data Cleaning\\MenuItem\\MenuItem_1-CleanedwOpenRefine.csv":
                    a = outfile.write(line)
                elif line_num != 0:
                    a = outfile.write(line)
                line_num += 1