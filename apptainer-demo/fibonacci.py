# Python program to display the Fibonacci sequence to the n-th term
import sys
nterms = int(sys.argv[1])

n1, n2 = 0, 1
count = 0

# check if the number of terms is valid
if nterms <= 0:
    print("Please enter a positive integer")
# if there is only 1 term, return n1
elif nterms == 1:
    print("Fibonacci sequence up to",nterms,"terms:")
    print(n1)
# generate Fibonacci sequence
else:
    print("Fibonacci sequence up to",nterms,"terms:")
    while count < nterms:
        print(n1)
        nth = n1 + n2
        # update values
        n1 = n2
        n2 = nth
        count += 1
