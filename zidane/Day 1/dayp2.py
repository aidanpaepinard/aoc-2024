list1 = []
list2 = []

with open('sample_input.txt', 'r') as lines:
    for line in lines:
        val = line.split()
        list1.append(int(val[0]))
        list2.append(int(val[1]))

res = {}
temp = 0

for ele in list1:
    res[ele] = 0

for a in range(len(list1)):
    for b in range(len(list2)):
        if (list1[a] == list2[b]):
            res[list1[a]] += 1

for k,v in res.items():
    temp += (k * v)

print(temp)