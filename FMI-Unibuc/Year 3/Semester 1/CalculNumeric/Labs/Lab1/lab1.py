import numpy as np
import matplotlib as plt
import scipy as sp

def findElem(k):
    x = 0.1
    for i in range(1, k + 1):
        if x < 0.5:
            x = x * 2
        else:
            x = x * 2 - 1
        print("{x:.50f}".format(x = x), end = " ")
        print()
    return x

print(findElem(60))

#2a), b)
n = 3
A = [[2, 4, -2], [4, 9, -3], [-2, -3, 7]]
b = [2, 8, 10]

def UTRIS(A, b, n):
    for k in range(0 , n - 1):
        for i in range(k + 1, n):
            # calculam miu-urile
            A[i][k] = ((-1) * A[i][k]) / A[k][k]   # Inf se suprascrie aici
            b[i] = b[i] + b[k] * A[i][k]

            # Aplica miuurile
            for j in range(k + 1, n):
                A[i][j] = A[i][j] + A[k][j] * A[i][k]

    A = np.triu(A) # face 0-uri sub diagonala

    return A, b
        
ASup, bSup = UTRIS(A, b, n)
print(ASup)
print(bSup)

def solve(A, b, n):
    x = b
    for i in range(n - 1, -1, -1):
        for j in range(i + 1, n):
            x[i] = x[i] - A[i][j] * x[j]
        x[i] = x[i] / A[i][i]
    return x

solvedSystem = solve(ASup, bSup, n)
print(solvedSystem)

# 2c)

m = 6
randomA = np.random.randn(m, m)
randomB = np.random.randn(m, 1)

aR, bR = UTRIS(randomA, randomB, m)
print(aR)
solved = solve(aR, bR, m)
print(solved)
