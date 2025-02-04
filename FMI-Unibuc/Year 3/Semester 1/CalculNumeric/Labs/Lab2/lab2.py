#Ex 1c din Lab2 

import numpy as np
import matplotlib.pyplot as plt
import scipy as sp
import seaborn as sns

input = np.genfromtxt('regresie.csv', delimiter=",")
z = []
w = []
for (x, y) in input:
    z.append(x)
    w.append(y)

#3a)

b = w
A = [[z[i], 1] for i in range(len(z))]

print(A)
print()
print(b)



#3b)

x = np.linalg.lstsq(A, b)[0]
print(x)

#3c)
x = np.array(x)
z = np.array(z)
w = np.array(w)


plt.plot(z, w, marker = "o", markersize = 8, markerfacecolor = "green")
plt.plot(z, x[0] * z + x[1], 'r')
plt.show()
