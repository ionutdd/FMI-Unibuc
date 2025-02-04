import numpy as np
import pickle
import matplotlib.pyplot as plt
import networkx as nx
from networkx.algorithms.approximation import *

# Exercitiul 1

def powerIteration(A, tol, max_iter):
    n = A.shape[0]
    y = np.random.rand(n)
    iter = 0
    err = 1

    while err > tol and iter < max_iter:
        y = y / np.linalg.norm(y)

        # Inmultirea cu matricea
        z = np.dot(A, y)

        # Normalizare
        z = z / np.linalg.norm(z)

        # Calcul eroare
        err = np.abs(1 - np.abs(np.dot(z, y)))

        # Actualizare vector si numar iteratii
        y = z
        iter += 1

    eigenvalue = np.dot(y.T, np.dot(A, y)) / np.dot(y.T, y)
    return y, eigenvalue


A = np.random.rand(6, 6)

eigenvectorPower, eigenvaluePower  = powerIteration(A, 1e-6, 1000)

eigenvalues, eigenvectors = np.linalg.eig(A)

idx = np.argmax(np.abs(eigenvalues))

print("Vector propriu dominant (Metoda Puterii):")
print(eigenvectorPower)
print("Valoare proprie dominanta (Metoda Puterii):", eigenvaluePower)

print("\nVector propriu dominant (numpy.linalg.eig):")
print(eigenvectors[:, idx])
print("Valoare proprie dominanta (numpy.linalg.eig):", eigenvalues[idx])



# Exercitiul 2

def uniqueWithTolerance(array, tolerance = 1e-6):
    unique_values = []
    for value in array:
        if not any(np.isclose(value, unique_value, rtol = tolerance) for unique_value in unique_values):
            unique_values.append(value)
    return np.array(unique_values)

print("\n------------------------------\n")

with open('grafuri.pickle', 'rb') as f: 
    matricesOfAdjancency = pickle.load(f)

# a) Obtinerea grafurilor asociate
graphs = [nx.from_numpy_array(matrix) for matrix in matricesOfAdjancency]

# # b) Vizualizarea grafurilor
# for i, G in enumerate(graphs):
#     plt.figure(i + 1)
#     nx.draw(G, with_labels = True)
#     plt.title(f"Graf {i + 1}")
#     plt.show()

# c) Calculul valorilor proprii si d) analiza proprietatilor
for i, G in enumerate(graphs):
    print(f"Pentru graful {i + 1}:")
    
    # Calculul valorilor proprii
    L = nx.adjacency_matrix(G).todense()  # Conversie la matrice densa
    eigenvalues, eigenvectors = np.linalg.eig(L)
    
    # Verificam daca graful este complet (are exact două valori proprii)
    if len(uniqueWithTolerance(eigenvalues)) == 2:
        print("Graful este complet.")
    else:
        print("Graful nu este complet.")
    
    # Verificam daca graful este bipartit (spectrul este simetric in origine)
    if np.allclose(max(eigenvalues), -min(eigenvalues)):
        print("Graful este bipartit.")
    else:
        print("Graful nu este bipartit.")
    
    # Gasirea dimensiunii maxime a unei clici
    cliqueSize = nx.algorithms.approximation.clique.max_clique(G)
    print(f"Dimensiunea maxima a unei clici: {len(cliqueSize)}")