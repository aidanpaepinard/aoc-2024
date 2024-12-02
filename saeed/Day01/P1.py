info = open("saeed\Day01\input.txt").readlines()

left= sorted(int(i.split()[0]) for i in info)
right= sorted(int(i.split()[1]) for i in info)

# # left.sort()
# # right.sort()

# total= (sum(abs(left[i] - right[i]) for i in range(len(left))))

# print(total)

print(sum(abs(left[i] - right[i]) for i in range(len(left))))