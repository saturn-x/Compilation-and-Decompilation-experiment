#run.py
import os
import sys
# from posix import times_result
from subprocess import *
import threading
import time
LexPath="my.l" #默认目录下是./my.l
LexEXE="myflex.exe"
OutputPath="./out/out.txt" #默认词法分析的结果是./out.txt
YourLanuage="../mylanguage/simple.rt" #自定义语言的位置
def out():
    with open(YourLanuage) as f:
        text=f.read()
    # print("读取源代码完毕:"+str(text))
    p =Popen(LexEXE,shell=True,stdin=PIPE,stdout=PIPE)
    p.stdin.write(text.encode("GBK"))
    p.stdin.close()
    result=p.stdout.read().decode("GBK")
    # print(result)
    print("词法分析结束，路径："+OutputPath)
    return result;
def lex():
    #调用lex
    os.system(
        "flex "+LexPath
    )
    os.system(
        "move ./lex.yy.c ./out/lex.yy.c"
    )
    print("调用lex成功")
def gcc():
    try:
        os.system(
            "gcc ./out/lex.yy.c -fexec-charset=gbk -o " +LexEXE
        )
        print("调用gcc成功")
        return True
    except:
        return False


#从lex.l -> 词法分析的结果
#直接调用
if(len(sys.argv)==1):
    #从lex.l运行lex
    #编译执行，a.exe
    #保存到./out.txt
    lex()
    gcc()
    with open(OutputPath,"w") as f:
        f.write(out())   
    

