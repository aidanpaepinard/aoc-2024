info = open("saeed/Day 2/input.txt").readlines()

argh = [list(map(int, x.split())) for x in info]

def safe(i):
    return any(all(a<(y-x)<b for x,y in zip(i, i[1:])) for a,b in[(0,4),(-4,0)])

dampSafe = (sum(any(safe(i[:x]+i[x+1:]) for x in range(len(argh))) for i in argh))

print(dampSafe)