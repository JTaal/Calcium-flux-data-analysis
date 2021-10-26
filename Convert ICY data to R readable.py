import pandas as pd
from os import read, walk
from os import listdir
from os.path import isfile, join

from pandas.core.frame import DataFrame

inputPathRaw = input("Give me the input folder: ")
outputPathRaw = input("Give me the output folder: ")
paths = [inputPathRaw, outputPathRaw]

for path in paths:    
    result = ""
    for chr in path:
        if chr == "\\":
            result += chr*2
        else:
            result += chr
    result += "\\"
    if path == inputPathRaw:
        inputPath = result
    elif path == outputPathRaw:
        outputPath = result

filesInFolder = [f for f in listdir(inputPath) if isfile(join(inputPath, f))]

for fileName in filesInFolder:
    if fileName[len(fileName)-5:] == ".xlsx":
        read_file = pd.read_excel (inputPath + fileName)
        read_file.to_csv (outputPath + fileName[:-5] + ".csv", index = None, header=True, sep= ",")
    elif fileName[len(fileName)-4:] == ".csv":
        read_file = pd.read_csv (inputPath + fileName, sep="\t", skiprows=[0])
        read_file.to_csv (outputPath + fileName[:-4] + ".csv", index = None, header=True, sep= ",")
    else:
        print(fileName, "not supported")
        continue
