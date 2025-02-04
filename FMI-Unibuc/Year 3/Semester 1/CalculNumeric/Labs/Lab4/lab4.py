import numpy as np
import numpy.linalg as la
import matplotlib.pyplot as plt
from sklearn.decomposition import PCA
import pandas

# Ex 1 a)
# Creati o matrice aleatoare A ∈ R unde m = 10 si r = 4. Calculati rangul matricii
print("1a)")
m = 10
r = 4

A = np.random.rand(m, r)
print(A)
rang = np.linalg.matrix_rank(A)
print(rang)

# Ex 1 b)
# Adaugati lui A un numar de 4 coloane liniar dependente a. i. 
# noua matrice va avea dimensiunea A ∈ R m×n, cu n = 8. 
# Pentru a crea noile coloane, luati o combinatie liniara de c = 3 coloane deja
# existente in A. Ati obtinut astfel o matrice de rang nemaximal.
# Verificati, calculand din nou rangul matricii.

print("1b)")
num_cols_new = 4
cols_to_combine = np.random.choice(r, size=3, replace=False)

# Generam coeficientii pentru combinatia liniara si alculam noile coloane ca si ombinatii liniare
coeffs = np.random.rand(num_cols_new, 3)
new_cols = np.zeros((m, num_cols_new)) 
for i in range(num_cols_new):
  for j in range(m):
    new_cols[j, i] = np.dot(coeffs[i, :], A[j, cols_to_combine])

# Adaugam noile coloane la matricea A
A_new = np.hstack((A, new_cols))
print(A_new)

# Verificăm rangul matricei noi
rang_new = np.linalg.matrix_rank(A_new)
print(rang_new)

# Ex 1 c)
# Adaugati la matricea obtinuta anterior un zgomot Gaussian de medie 0 si dispersie 0.02. Calculati rangul noii matrici.

print("1c)")
noise = np.random.normal(0, 0.02, A_new.shape)
A_noisy = A_new + noise
print(A_noisy)
rang_noisy = np.linalg.matrix_rank(A_noisy)
print(rang_noisy)

# Ex 1 d)
# Calculati descompunerea valorilor singulare pentru matricea de mai sus i afisati valorile singulare.

print("1d)")
U, S, V = np.linalg.svd(A_noisy)
print(S)


# Ex 2 a)

# Transformati imaginea imageToSVD.jpg aleasa aleator intr-o matrice si calculati SVD.
print("2a)")
image = plt.imread("imageToSVD.jpg")
img_array = np.array(image)
print(img_array.shape)
print(img_array)
if len(img_array.shape) == 3:
    img_gray = np.mean(img_array, axis=2)
else:
    img_gray = img_array

U, S, VT = np.linalg.svd(img_gray)
print(S)

# Ex 2 b)
# Alegeti un rang k pentru care vreti sa obtineti aproximarea matricii de mai sus, a.i. k < min(m, n), unde m si n reprezinta dimensiunile matricii. 
# Obtineti aproximarea de rang k a matricii, trunchiind valorile singulare.

print("2b)")
k = 50
S_k = np.diag(S[:k])
U_k = U[:, :k]
VT_k = VT[:k, :]
img_gray_approx = U_k @ S_k @ VT_k
print(img_gray_approx)

# Ex 2 c)
# Vizualizati noua imagine

# plt.imshow(img_gray_approx, cmap='gray')

# Ex 2 d)
# Repetati pentru 2 − 3 valori ale lui k alese in functie de dimensiunea
# imaginii, pentru a vedea gradul de compresie in fiecare caz.


k_values = [10, 50, 100]
for k in k_values:
    S_k = np.diag(S[:k])
    U_k = U[:, :k]
    VT_k = VT[:k, :]
    img_gray_approx = U_k @ S_k @ VT_k
    # plt.imshow(img_gray_approx, cmap='gray')
    # plt.show()

# Ex 3
# Utilizati PCA pentru a reduce dimensiunea semnalelor din baza de dateiris, disponibila la adresa
# https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data
# Alegeti numarul de componente principale ncomponents = 2 si vizualizati noul set de date.


data = pandas.read_csv('https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data')
X = data.iloc[:, :-1].values 

pca = PCA(n_components=2)
components = pca.fit_transform(X)

#Vizualizare
# plt.scatter(components[:, 0], components[:, 1])
# plt.show()