totalDistance = 0

# Read Data from file
with open('input.txt','r') as file:
    lines = file.readlines()
    
# Get seperate lists of integers
list1 = []
list2 = []

for line in lines:
    if line.strip():
        num1, num2 = map(int, line.split())
        list1.append(num1)
        list2.append(num2)

# Sort Lists
list1.sort()
list2.sort()

# Get distance for each value and find total distance
for num1, num2 in zip(list1, list2):
    distance = abs(num1 - num2)
    totalDistance += distance

print(totalDistance)