import re

#need to go through string and use mul functions when there is a do function before it. 
#Any mul functions are disregarded if there is a dont function

info= open("saeed/Day 3/input.txt").read()
total= 0
all= []
valid= True

for i in re.finditer('mul\((\d{1,3}),(\d{1,3})\)', info):
    all.append(("mul", i.start(), i.groups()))

for i in re.finditer('do\(\)', info):
    all.append(("do", i.start(), None)) 

for i in re.finditer('don\'t\(\)', info):
    all.append(("dont", i.start(), None))

#now sort everything by the string index so its in order
all.sort(key= lambda x:x[1])

for func, meh, groups in all:
    if func== "do":
        valid= True
    elif func== "dont":
        valid= False
    elif func== "mul" and valid== True:
        x,y= groups
        total+= int(x)*int(y)


print(total)
