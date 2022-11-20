import re
file = open('nand2tetris/projects/06/rect/Rect.asm')
lineno = 0;
Symboltable={"R0":"0","R1":"1","R2":"2","R3":"3","R4":"4","R5":"5","R6":"6","R7":"7","R8":"8","R9":"9","R10":"10","R11":"11","R12":"12","R13":"13","R14":"14","R15":"15",
"SCREEN":"16384","KBD":"24576","SP":"0","LCL":"1","ARG":"2","THIS":"3","THAT":"4"}
codeline={}
jnk={}
i=16
#--------------C instruction logic------------------
def cinst(dest,comp,jump):
    if "A" in dest:
        d1="1"
    else:
        d1="0"
    if "D" in dest:
        d2="1"
    else:
        d2="0"
    if "M" in dest:
        d3="1"
    else:
        d3="0"
    dict={"0":"0101010","1":"0111111","-1":"0111010","D":"0001100","A":"0110000","!D":"0001101","!A":"0110001","-D":"0001111","-A":"0110001","D+1":"0011111","A+1":"0110111",
    "D-1":"0011111","A+1":"0110111","D-1":"0001110","A-1":"0110010","D+A":"0000010","D-A":"0010011","A-D":"0000111","D&A":"0000000","D|A":"0010101","M":"1110000","!M":"1110001",
    "-M":"1110011","M+1":"1110111","M-1":"1110010","D+M":"1000010","D-M":"1010011","M-D":"1000111","D&M":"1000000","D|M":"1010101","null":"000","JGT":"001","JEQ":"010","JGE":"011",
    "JLT":"100","JNE":"101","JLE":"110","JMP":"111"}
    print("111"+dict[comp]+d1+d2+d3+dict[jump])

#--------------Line count------------------
def linecount(file,lineno,codeline):
    #print("**")
    for lines in file:
        linestr=lines.strip()
        if linestr.startswith("(") or linestr.startswith("//") or linestr.startswith("\n"):
            codeline.update( {lines : lineno} )
            #print(lines,lineno)      #for debugging
            continue
        else:
            lineno=lineno+1
            codeline.update( {lines : lineno} )
            #print(lines,lineno)      #for debugging

#---`-----------Appending Symbol Table------------------
def symtable(file,codeline,Symboltable):
     linecount(file,lineno,codeline)
     for l in file:
         #print("****")#IT DOESNT EXCECUTR THIS LOOP I DONT KNOW WHY
         l1=l.strip( )
         if l1.startswith("("):
                loopno=int(codeline[l1])+1
                loopvar=l.strip(' ()')
                Symboltable.update( {loopvar : loopno} )
     for l in file:
         l1.strip( )
         if l.startswith("@"):
                x = l1[1:]
                if x not in Symboltable:
                    x=i
                    xvar= l1[1:]
                    Symboltable.update( {xvar : x} )
                    i=i+1
                    x=int(x)
                    #print(x)
     return(x)
        #print(Symboltable)  ##for debugging
        #print(codeline)     ##for debugging

#------Boolean conversions and A instruction logic----------

for line in file:
    line1=line.strip( )
    if line1.startswith("@"):
        try:
            x = line1[1:]
            c=(bin(int(x)))
            code=c.split('b')
            print(code[1].zfill(16))
        except:
            symtable(file,codeline,Symboltable)
            #print(x)
            c=(bin(int(x)))
            code=c.split('b')
            print(code[1].zfill(16))
    elif line1.startswith("//") or line1.startswith("\n") or line1.startswith("     ") or line1.startswith("["):
        continue
    else:
        if "=" in line1 and ";" not in line1: #DEST=COMP;JUMP
                a=line1.split("=")
                dst=a[0]
                cmp=a[1]
                s=cmp.split("\n")
                cmp1=s[0]
                jmp1="null"
        elif "=" not in line1 and ";" in line1:  #COMP;JUMP
                a1=line1.split(";")
                cmp1=a1[0]
                jmp=a1[1]
                s1=jmp.split("\n")
                jmp1=s1[0]
                dst="null"
        else:                                    #DEST=COMP
                a2=line.split("=")
                dst=a2[0]
                a3=a2[0].split(";")
                cmp1=a3[1]
                s2=cmp1.split("\n")
                jmp1=s2[0]
                #print(a3)

        cinst(dst,cmp1,jmp1)
