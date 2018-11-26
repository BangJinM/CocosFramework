
import os
import sys

def readBinaryFileToBinaryArray(fullPath):
    file = open(fullPath, "rb")
    filedata = file.read()
    fileSize = file.tell()
    file.close()
    return bytearray(filedata) ,fileSize

def encryptPng(fullPath):
    data,size = readBinaryFileToBinaryArray(fullPath)
    print("size:%ld"%size)
    print(fullPath)

def encryptJpg(fullPath):
    print(fullPath)

def encrypt(fullPath,fileName):
    _,postfis = os.path.splitext(fileName)
    if postfis == ".png" :
        encryptPng(fullPath)
        return
    elif postfis == ".jpg":
        encryptJpg(fullPath)
        return

def foreachPath(rootPath):
    exists = os.path.exists(rootPath)
    if exists == False :
        print("the file is not exists! file path = " + rootPath)
        return

    filePath = os.listdir(rootPath)
    for file in filePath :
        fullPath = os.path.join(rootPath,file)
        #isFile = os.path.isdir(fullPath)
        isFile = os.path.isfile(fullPath)
        if isFile:
            encrypt(fullPath,file)
        else:
            foreachPath(fullPath)


# -------------- main --------------
if __name__ == '__main__':
    current_dir = os.path.dirname(os.path.realpath(__file__))
    resource_root = os.path.join(current_dir,"Resources")
    foreachPath(resource_root)
    