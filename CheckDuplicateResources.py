import os
import sys
import hashlib

class Value:
    num = 1 
    md5 = ""
    path = []
    name = []
    def __init__(self, md5,path,name):
        self.md5 = md5
        self.path = []
        self.name = []
        self.path.append(path)
        self.name.append(name)
values = {}

class Log:

    def __init__(self,path):
        self.path = path
        if os.path.exists(path): 
            os.remove(path)
        self.fileLog = open(path,'w')
        self.close()

    def log(self,str):
        self.fileLog = open(self.path, 'a')
        self.fileLog.write(str)
        self.close()

    def close(self):
        if self.fileLog :
            self.fileLog.close()

def foreachPath(rootPath):
    exists = os.path.exists(rootPath)
    if exists == False :
        print("the file is not exists! file path = " + rootPath)
        return
    filePath = os.listdir(rootPath)
    for file in filePath :
        fullPath = os.path.join(rootPath,file)
        isFile = os.path.isfile(fullPath)
        if isFile:
            checkMd5(fullPath,file)
        else:
            foreachPath(fullPath)

def getFileMd5(fullPath):
    file = open(fullPath, "rb")
    md5 = hashlib.md5(file.read()).hexdigest()
    return md5

def checkMd5(fullPath,fileName):
    md5 = getFileMd5(fullPath)
    temp = Value(md5,fullPath,fileName)
    if values.has_key(md5):
        value = values.get(md5)
        if(value != None):
            temp = value
            temp.num = value.num + 1
            temp.name.append(fileName)
            temp.path.append(fullPath)
    values[md5] = temp
    
def get_FileSize(filePath):
    fsize = os.path.getsize(filePath)
    fsize = fsize/float(1024)
    return fsize

def printMD5(path):
    wasteSize = float(0.0)
    log = Log(path)
    for _, value in values.items():
        if(value.num >= 2):
            size = get_FileSize(value.path[0])
            wasteSize += size * (value.num - 1.0)
            for i in range(value.num):  
                str = "num:%d\t\tname:%s\t\tfullPahth:%s\t\tmd5:%s\n"%(value.num,value.name[i-1],value.path[i-1],value.md5)
                print("num:%d\t\tname:%s\t\tfullPahth:%s\t\tmd5:%s\n"%(value.num,value.name[i-1],value.path[i-1],value.md5))
                log.log(str)
            print("\n")
            log.log("\n\n\n")
    print("wasteSize:%f"%(wasteSize))
    log.log("wasteSize:%f"%(wasteSize))

if __name__ == '__main__':
    current_dir = os.path.dirname(os.path.realpath(__file__))
    resource_root = os.path.join(current_dir,"Resources")
    foreachPath(resource_root)
    printMD5(os.path.join(current_dir,"text.txt"))
    dir = raw_input()