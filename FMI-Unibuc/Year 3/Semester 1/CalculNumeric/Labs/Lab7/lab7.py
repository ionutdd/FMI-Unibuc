from dictlearn import DictionaryLearning
from dictlearn import methods
from matplotlib import image
from sklearn.feature_extraction.image import extract_patches_2d
from sklearn.feature_extraction.image import reconstruct_from_patches_2d
from sklearn.preprocessing import normalize
import numpy as np
from matplotlib import pyplot as plt

p = 8 # dimensiunea unui patch (numar de pixeli)
s = 6 # sparsitatea
N = 1000  # numarul total de patch-uri
n = 256 # numarul de atomi din dictionar
K = 50 # numarul de iteratii DL
sigma = 0.075 # deviatia standard a zgomotului

# 1. Pregatirea imaginii. 
# (a) Incarcati imaginea. Vetti obtine imaginea I de dimensiune m1 x m2. 

I = image.imread('floare.png')
I = I[:, :, 0]

# (b) Adaugati zgomot cu dispersie sigma imaginii, folosind secventa Inoisy = I + sigma*np.random.randn(I.shape[0],I.shape[1])
Inoisy = I + sigma*np.random.randn(I.shape[0], I.shape[1])

# (c) Extrageti patch-urile din imaginea Inoisy si memorati-le in variabila Ynoisy. 
# Functia extract_patches_2d va returna colectia de patch-uri, insa pentru a putea fi utilizate in continuare in antrenarea dictionarului e nevoie de ajustarea dimensiunii, respectiv de vectorizarea patch-urilor. 
# Afisati intai dimensiunea Ynoisy. Pentru a vectoriza patch-urile folositi Ynoisy = Ynoisy.reshape(Ynoisy.shape[0],-1). Afisati din nou dimensiunea Ynoisy, pentru a observa rezultatul vectorizarii. 
# Transpuneti matricea, apoi calculati media semnalelor pe linii (axa 0), reprezentand media patch-urilor, si scadeti-o din Ynoisy.

Ynoisy = extract_patches_2d(Inoisy, (p, p))
print("Ynoisy.shape: ", Ynoisy.shape)
Ynoisy = Ynoisy.reshape(Ynoisy.shape[0], -1)
print("Ynoisy.shape after vectorization: ", Ynoisy.shape)


Ynoisy = Ynoisy.T
mean_Ynoisy = np.mean(Ynoisy, axis=0)  
Ynoisy -= mean_Ynoisy  


# (d) Selectati N patch-uri de dimensiune p la intamplare din imagine, obtinand astfel semnalele Y. 
# Pentru aceasta, utilizati numpy.random.choice(Ynoisy.shape[1],N).

Y = Ynoisy[:, np.random.choice(Ynoisy.shape[1], N)]

# 2. Antrenarea dictionarului. 
# (a) Generati un dictionar aleator si normati coloanele, obtinand dictionarul D0. 

D0 = np.random.randn(p**2, n)
D0 = normalize(D0, axis=0, norm='max')

# (b) Antrenati dictionarul D pornind de la dictionarul D0 initializat mai sus, in K iteratii utilizand patch-urile selectate Y ca semnale de antrenare.

dl = DictionaryLearning( n_components=n, max_iter=K, fit_algorithm='ksvd', n_nonzero_coefs=s, code_init=None, dict_init=D0, params=None, data_sklearn_compat=False ) 
dl.fit(Y)
D = dl.D_

# 3. Calcul reprezentarii rare si reconstructia imaginii. 
# (a) Calculati reprezentarea rara a semnalelor Ynoisy, obtinand Xc. 

Xc, err = methods.omp(Ynoisy, D, n_nonzero_coefs=s)

# (b) Obtineti patch-urile curate, Yc, utilizand dictionarul D si reprezentarea Xc, apoi adaugati media pe linii pe care ati scazut-o anterior. 

Yc = np.dot(D, Xc)
Yc += mean_Ynoisy

# (c) Reconstruiti imaginea din patch-urile Yc, obtinand imaginea curata Ic.

Yc = Yc.T
Yc = Yc.reshape(Yc.shape[0], p, p)
Ic = reconstruct_from_patches_2d(Yc, (I.shape[0], I.shape[1]))

# 4. Evaluarea performantei.

def psnr(img1, img2): 
    mse = np.mean((img1- img2) ** 2) 
    if(mse == 0): 
        return 0 
    max_pixel = 255 
    psnr = 20 * np.log10(max_pixel / np.sqrt(mse)) 
    return psnr

# (a) Vizualizati cele trei imagini (originala, alterata de zgomot si curatata de zgomot). 
# Pentru aceasta, folositi plt.imshow(I), dupa ce ati incarcat pachetul from matplotlib import pyplot as plt.

plt.figure()
plt.imshow(I, cmap='gray')
plt.title("Original Image")
plt.show()
plt.imshow(Inoisy, cmap='gray')
plt.title("Noisy Image")
plt.show()
plt.imshow(Ic, cmap='gray')
plt.title("Clean Image")
plt.show()

# (b) Calculati psnr pentru a masura reducerea zgomotului. Calculati atat psnr intre imaginea originala si cea afectata de zgomot, 
# cat si intre cea originala si cea in care ati eliminat zgomotul. Daca valoarea obtinuta pentru imaginea denoised este mai mare decat pentru cea noisy, 
# metoda si-a indeplinit scopul.

psnr_noisy = psnr(I, Inoisy)
psnr_denoised = psnr(I, Ic)
print("PSNR noisy: ", psnr_noisy)
print("PSNR denoised: ", psnr_denoised)