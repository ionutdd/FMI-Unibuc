# Ex 1 a)  Utilizati algoritmul SVM pentru a clasifica semnalele din baza de date Iris. 
# Creati 2 seturi de date: unul de antrenare si unul de test. Setul de antrenare contine Ntrain = 100 semnale extrase in mod aleator din fiecare clasa de flori. 
# Setul de test contine restul de Ntest = 50 semnale.

import numpy as np
from sklearn import datasets
from sklearn.model_selection import train_test_split
from sklearn.svm import SVC
from sklearn.metrics import accuracy_score
import pandas
from sklearn.metrics import confusion_matrix

data = pandas.read_csv('https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data')

X = data.iloc[:, :-1].values
y = data.iloc[:, 4].values

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.33)

# b) Antrenati algoritmul SVM pe setul de antrenare folosind un kernel liniar si 
# c) Testati performanta algoritmului pe setul de test, calculand eroarea de clasificare si matricea de confuzie.

def SVCType(X_train, X_test, y_train, y_test, SVCType):
    clf = SVC(kernel=SVCType)
    clf.fit(X_train, y_train)

    y_pred = clf.predict(X_test)

    accuracy = accuracy_score(y_test, y_pred)
    print("Accuracy: ", accuracy)

    error = 1 - accuracy
    print("Error: ", error)

    conf_matrix = confusion_matrix(y_test, y_pred)
    print("Confusion matrix: ")
    print(conf_matrix)

SVCType(X_train, X_test, y_train, y_test, 'linear')

# d) Refaceti experimentul utilizand de data asta un kernel de tip RBF.

print()
print("RBF kernel")
print()

SVCType(X_train, X_test, y_train, y_test, 'rbf')