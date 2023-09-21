import os

count = 0
max = 0
maxFile = ""
fileLengh = 0
# get list of files in lib directory
for root, directories, files in os.walk("./lib", topdown=False):
    for name in files:
        fileLengh+=1
        file = open(os.path.join(root, name), encoding="utf8")
        # get line of file
        lineFile = 0
        for line in file:
            if line != "\n":
                count += 1
                lineFile += 1
        if lineFile > max:
            max = lineFile
            maxFile = name
        file.close()
print("Number of lines of code:", count)
print("Number of Files:", fileLengh)
print("File with most lines of code:", maxFile)
print("Number of lines of code in file with most lines of code:", max)
add_str = f"""
## Count lines of codes: {count}
## Number of Files:: {fileLengh}
## File with most lines of code: {maxFile}
## Most lines of code in one file: {max}
"""
