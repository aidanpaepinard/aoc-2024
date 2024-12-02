import math

def load_data(filename: str) -> tuple:
    left, right = [], []

    with open (filename, "r") as puzzle_input:
        for line in puzzle_input:
            data = line.split()
            left.append(data[0])
            right.append(data[1])

    return (left, right)

raw = load_data("puzzle_input.txt")
left = raw[0]
left.sort()
right = raw[1]
right.sort()
dist = 0

for _ in range(len(left)):    
    dist += math.fabs(int(left[_]) - int(right[_]))

print(int(dist))