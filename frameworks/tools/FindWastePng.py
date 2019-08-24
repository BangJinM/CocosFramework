import os
import sys
import re

images = {}
luaImage = {}

points = {".","/"}
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

def checkPng(fullPath):
    print(fullPath)
    _,fileType = os.path.splitext(fullPath)
    if ".png" == fileType or ".jpg" == fileType:
        images[fullPath] = 0

def foreachPng(path):
    exists = os.path.exists(path)
    if exists == False :
        print("the file is not exists! file path = " + path)
        return
    filePath = os.listdir(path)
    for file in filePath :
        fullPath = os.path.join(path,file)
        isFile = os.path.isfile(fullPath)
        if isFile:
            checkPng(fullPath)
        else:
            foreachPng(fullPath)

def checkCsbAndLua(path,rootPath,rule):
    _,fileType = os.path.splitext(path)
    if ".lua" == fileType or ".csb" == fileType :
        with open(path, 'r') as checkFile:
            text = checkFile.read()
            rule = "%s/[^\s]*.png"%(rule)
            pattern = re.compile(rule,re.S) 
            results =  pattern.findall(text) 
            for result in results:
                if not luaImage.has_key(result):
                    luaImage[result] = 0

def foreachCsbAndLua(path,rootPath,rule):
    exists = os.path.exists(path)
    if exists == False :
        print("the file is not exists! file path = " + path)
        return
    filePath = os.listdir(path)
    for file in filePath :
        fullPath = os.path.join(path,file)
        isFile = os.path.isfile(fullPath)
        if isFile:
            checkCsbAndLua(fullPath,rootPath,rule)
        else:
            foreachCsbAndLua(fullPath,rootPath,rule)

def printPng(path,resource_root):
    log = Log(path)
    # allCount = 0
    # waCount = 0
    # for key, value in images.items():
    #     flag = False
    #     allCount = allCount + 1
    #     strs = key.split(resource_root+"\\")
    #     tempKey = strs[1]
    #     resultKey = tempKey.replace("\\","/")
    #     for k,v in luaImage.items():
    #         if resultKey == k:
    #             flag = True
    #             break
    #     if not flag:
    #         print(resultKey)
    #         log.log(resultKey)
    #         log.log("\n")
    #         waCount = waCount + 1
    # log.log("allCount:%f\n"%(allCount))
    # log.log("waCount:%f\n"%(waCount))
    for key, value in images.items():
        flag = False
        strs = key.split(resource_root+"\\")
        tempKey = strs[1]
        resultKey = tempKey.replace("\\","/")
        print(resultKey)
        log.log(resultKey)
        log.log("\n")
    log.log("---------------------------------------------------------")
    for k,v in luaImage.items():
        log.log(k)
        log.log("\n")
if __name__ == '__main__':
    current_dir = os.path.dirname(os.path.realpath(__file__))
    resource_root = os.path.join(current_dir,"proj.cocos/res")
    src_root = os.path.join(current_dir,"proj.cocos/src")
    studio_root = os.path.join(current_dir,"cocosstudio")
    foreachPng(resource_root)

    foreachCsbAndLua(src_root,resource_root,"lobby")
    foreachCsbAndLua(src_root,resource_root,"common")
    foreachCsbAndLua(src_root,resource_root,"games")

    foreachCsbAndLua(studio_root,resource_root,"lobby")
    foreachCsbAndLua(studio_root,resource_root,"common")
    foreachCsbAndLua(studio_root,resource_root,"games")

    printPng(os.path.join(current_dir,"text.txt"),resource_root)
    dir = raw_input()