totalSimilarity= 0

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

# Get Similarity for each value and find total Similarity
for num1 in list1:
    if list2.count(num1) > 0:
        similarity = num1 * list2.count(num1)
        totalSimilarity += similarity

print(totalSimilarity)