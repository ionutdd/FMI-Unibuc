#1 BF

m = [
    [0, 1, 0, 1, 1, 0, 0, 0, 0, 0],
    [1, 0, 1, 0, 0, 1, 0, 0, 0, 0],
    [0, 1, 0, 0, 0, 1, 0, 1, 0, 0],
    [1, 0, 0, 0, 0, 0, 1, 0, 0, 0],
    [1, 0, 0, 0, 0, 0, 0, 1, 0, 0],
    [0, 1, 1, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
    [0, 0, 1, 0, 1, 0, 0, 0, 1, 1],
    [0, 0, 0, 0, 0, 0, 0, 1, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 1, 0, 0]
]


start = 0
scopuri = [5, 9]


class NodArbore:
    def __init__(self, informatie, parinte = None):
        self.informatie = informatie
        self.parinte = parinte

    def drumRadacina (self):
        nod = self
        lDrum = []
        while nod:
            lDrum.append(nod)
            nod = nod.parinte
        return lDrum[::-1]

    def inDrum (self, infonod):
        nod = self
        while nod:
            if nod.informatie == infonod:
                return True
            nod = nod.parinte
        return False


    def __str__(self):
        return str(self.informatie)
    
    def __repr__(self):
        return "{}, ({})".format(str(self.informatie) , "->".join([str(x) for x in self.drumRadacina()]))


#2 clasa Graf
    
class Graf:
    def __init__(self, matr, start, scopuri):
        self.matr = matr
        self.start = start
        self.scopuri = scopuri

    def scop(self, informatieNod):
        return informatieNod in self.scopuri

    def succesori(self, nod):
        lSuccesori = []
        for infoSuccesor in range(len(self.matr)):
            if self.matr[nod.informatie][infoSuccesor] == 1 and not nod.inDrum(infoSuccesor):
                lSuccesori.append(NodArbore(infoSuccesor, nod))
        return lSuccesori


#3 BF
    
def breadthFirst(gr, nsol = 2):
    coada = [NodArbore(gr.start)]
    while coada:
        nodCurent = coada.pop(0)
        if gr.scop(nodCurent.informatie):
            print(repr(nodCurent))
            nsol -= 1
            if nsol == 0:
                return
        coada += gr.succesori(nodCurent)


gr = Graf(m, start, scopuri)
breadthFirst(gr, nsol = 3)


#Tema

#4

def depthFirstRec(gr, nsol):

    startNode = NodArbore(gr.start)
    nsol_remaining = [nsol]

    def depthFirstRecursiv(nodCurent, nsol):
        if gr.scop(nodCurent.informatie):
            print(repr(nodCurent))
            nsol[0] -= 1

            if nsol[0] == 0:
                return True
            
        for succesor in gr.succesori(nodCurent):
            if depthFirstRecursiv(succesor, nsol):
                return True
            
        return False

    depthFirstRecursiv(startNode, nsol_remaining)


#5

def depthFirst(gr, nsol):
    stack = [NodArbore(gr.start)]
    
    while stack:
        nodCurent = stack.pop()
        
        if gr.scop(nodCurent.informatie):
            print(repr(nodCurent))
            nsol -= 1
            if nsol == 0:
                return
        
        stack.extend(gr.succesori(nodCurent)[::-1])
    

nsol = int(input("Numarul de solutii = "))
gr = Graf(m, start, scopuri)
print("")
print("Exercitiul 4, DF recursiv: ")
depthFirstRec(gr, nsol)

print("")
print("Exercitiul 5, DF nerecursiv: ")

depthFirst(gr, nsol)



#6

def breadthFirst2(gr, nsol=2):
    coada = [NodArbore(gr.start)]
    nodCurent = coada.pop(0)

    if gr.scop(nodCurent.informatie):
        print(repr(nodCurent))
        nsol -= 1
        if nsol == 0:
            return
    
    coada = [NodArbore(gr.start)]
    
    while coada and nsol > 0:
        nodCurent = coada.pop(0)
        succesori = gr.succesori(nodCurent)
        coada.extend(succesori)

        for succesor in succesori:
            if gr.scop(succesor.informatie):
                print(repr(succesor))
                nsol -= 1
                if nsol == 0:
                    return
            
    
print("")
print("Exercitiul 6, BF printare solutie imediat dupa ce e ad in coada: ")
breadthFirst2(gr, nsol = 3)