# Presupunem ca ne dorim sa modelam pretul apartamentelor dintr-un anumit oras. Nu avem acces la toate preturile, ci doar la un subset de 10 astfel de valori, 
# exprimate in mii de euro: x = [82, 106, 120, 68, 83, 89, 130, 92, 99, 89]. 

# Ex 1)
# Pentru inceput consideram valori cunoscute pentru medie si dispersie. Mai tarziu, vom cauta valori optime pentru aceste marimi.
#  Setati µ = 90 s si σ = 10. Afisati distributia normala ce corespunde acestor valori.

import numpy as np
import scipy.stats as stats
import matplotlib.pyplot as plt

mu = 90
sigma = 10

x = [82, 106, 120, 68, 83, 89, 130, 92, 99, 89]
y = stats.norm.pdf(x, mu, sigma)

# Afisati distributia normala ce corespunde acestor valori.

plt.plot(x, y)
print("Distributia normala: ")
print(y)


# Ex 2
# Calculati verosimiltatea de a obtine valoarea de a obtine x1 = 82 din distributia normala de mai sus. Intai utilizati formula P(x|Θ) = 1 √ 2σ2 2πσ2 e−(x−µ)2, 
# apoi functia scipy.stats.norm.pdf(x, mu, sigma). Verificati ca obtineti acelasi rezultat.

x1 = 82
y1 = stats.norm.pdf(x1, mu, sigma)
y2 = 1 / np.sqrt(2 * np.pi * sigma ** 2) * np.exp(-(x1 - mu) ** 2 / (2 * sigma ** 2))

print("Verosimilitatea de a obtine valoarea x1 = 82: ")
print(y1)
print(y2)

# Ex 3
# Utilizati functia de mai sus pentru a calcula verosimilitatea tuturor datelor x.

y = stats.norm.pdf(x, mu, sigma)
print("Verosimilitatea tuturor datelor x: ")
print(y)

# Ex 4
# Presupuneti o distributie normala pentru probabilitatea de a cunoaste media a priori: in intreaga tara preturile sunt distribuite normal si 
# au o valoare medie de 100 si o dispersie de 50. De asemenea, presupuneti o probabilitate a priori pentru dispersie astfel incat aceasta saa fie uniform distribuita in intervalul [1,70].

mu_prior = 100
sigma_prior = 50
sigma_prior_min = 1
sigma_prior_max = 70

def prior_miu(miu):
    return stats.norm.pdf(miu, mu_prior, sigma_prior)

def prior_sigma(sigma):
    return stats.uniform.pdf(sigma, sigma_prior_min, sigma_prior_max)

Pmiu = prior_miu(mu)
Psigma = prior_sigma(sigma)

print("Probabilitatea a priori pentru media: ", Pmiu)
print("Probabilitatea a priori pentru dispersie: ", Psigma)

# Ex 5
# Calculati verosimilitatea datelor x pentru aceasta distributie normala a mediei si dispersiei.

y = stats.norm.pdf(x1, mu_prior, sigma_prior) * prior_miu(mu_prior) * prior_sigma(sigma)
print("Verosimilitatea datelor x pentru aceasta distributie normala a mediei si dispersiei: ")
print(y)

# Ex 6
# Pana acum am testat un singur model, respectiv acela avaand parametrii µ = 90 si σ = 10. Pentru a gasi, insa, modelul cel mai bun, va trebui sa calculam 
# probabilitatea a posteriori pentru o serie de candidati si sa-l selectam pe acela cu probabilitatea ce mai mare. 
# Utilizati urmatorul set de valori posibile ale parametrilor modelului µ = [70,75,80,85,90,95,100], respectiv σ = [5,10,15,20]. Care din aceste modele este optim?

mu = [70, 75, 80, 85, 90, 95, 100]
sigma = [5, 10, 15, 20]
max_prob = 0
best_mu = 0
best_sigma = 0

print("Probabilitatea a posteriori pentru fiecare model: ")
for i in range(len(mu)):
    for j in range(len(sigma)):
        y = stats.norm.pdf(x, mu[i], sigma[j])
        prob = np.prod(y)
        print(mu[i], sigma[j], prob)
        if prob > max_prob:
            max_prob = prob
            best_mu = mu[i]
            best_sigma = sigma[j]

print("Best model: mu = ", best_mu, "sigma = ", best_sigma, "prob = ", max_prob)