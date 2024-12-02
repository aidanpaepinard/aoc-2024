def difference_between_lists(list1, list2):
    difference = []
    for a in range(len(list1)):
        difference.append(abs(list1[a] - list2[a]))
    return difference


def sum_of_list(list):
    sum = 0
    for a in list:
        sum += a
    return sum

list1 = []
list2 = []


with open('sample_input.txt', 'r') as lines:
    for line in lines:
        val = line.split()
        list1.append(int(val[0]))
        list2.append(int(val[1]))


list1.sort()
list2.sort()

print("Difference between the lists: ", difference_between_lists(list1, list2))
print("Sum of the lists: ", sum_of_list(difference_between_lists(list1, list2)))
