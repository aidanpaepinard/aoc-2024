info = open("saeed/Day 2/input.txt").readlines()

argh = [list(map(int, x.split())) for x in info]

# for x in argh:
#any() = returns true if any items in a list are true
#all() = returns true if all items in a list are true
#in a for loop, a,b in[(0,3),(-3,0)] == first iteration a=0, b=3... second iteration a=-3, b=0

total = (sum(any(all(a<(y-x)<b for x,y in zip(i, i[1:])) for a,b in[(0,4),(-4,0)]) for i in argh))
#steps = sum over entire list of lists, any list that return true to the all() function. This means the list is safe
#using 4 and -4 as parameters as the difference can be between 1 and 3... so <4

print(total)