from collections import Counter

info = open("saeed\Day01\input.txt").readlines()

left= sorted(int(i.split()[0]) for i in info)
right= sorted(int(i.split()[1]) for i in info)

#balatro reference
mult= Counter(right)

# total= sum(i* mult[i] for i in left)

# print(total)

print(sum(i* mult[i] for i in left))