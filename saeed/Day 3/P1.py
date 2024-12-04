import re

info= open("saeed/Day 3/input.txt").read()

total= 0

for mult in re.finditer('mul\((\d{1,3}),(\d{1,3})\)', info):
    x,y= mult.groups()
    total+= int(x) * int(y)

print(total)

# quack= re.search('mul\((\d{1,3}),(\d{1,3})\)', info)
# x, y= quack.groups()
# print(x)
# print(y)

#mul(323,598)

