info = open("saeed/Day 4/input.txt").readlines()

def checkDirections(row, col, dr, dc, info):
    if not(0<= row+3*dr <len(info) and 0<= col+3*dc <len(info[0])):
        return False
    elif(info[row][col]== 'X' and info[row+dr][col+dc]== 'M' and info[row+2*dr][col+2*dc]== 'A' and info[row+3*dr][col+3*dc]== 'S'):
        return True

def xmas(info):
    directions= [(1,0),(0,1),(-1,0),(0,-1),(1,1),(-1,-1),(1,-1),(-1,1)]
    count= 0

    for x in range(len(info)):
        for y in range(len(info[0])):
            for dr, dc in directions:
                if(checkDirections(x,y,dr,dc,info)):
                    count+= 1
    return count

print(xmas(info))