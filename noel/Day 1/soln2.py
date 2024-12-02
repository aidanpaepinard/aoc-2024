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
similarity = 0
appearances = {}

for i in range(len(left)):
    count = 0 
    for j in range(len(left)):
        if (left[i] == right[j]):
            count += 1
        
        if (right[j] > left[i]):
            break

    appearances[left[i]] = count

for num, occurances in appearances.items():
    similarity += int(num) * int(occurances)

print(similarity)