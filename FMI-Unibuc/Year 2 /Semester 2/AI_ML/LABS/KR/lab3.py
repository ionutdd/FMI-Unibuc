import time
import queue

class NodArbore:
    def __init__(self, informatie, g = 0, h = 0, parinte = None):
        self.informatie = informatie
        self.parinte = parinte
        self.g = g
        self.h = h
        self.f = g + h

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
        return f"({str(self.informatie)}, g:{self.g} f:{self.f})"
    
    def __repr__(self):
        return "{}, ({})".format(str(self.informatie) , "->".join([str(x) for x in self.drumRadacina()]))
    
    def __eq__(self, other):
        return self.f == other.f and self.g == other.g
    
    def __lt__(self, other):
        return self.f < other.f or (self.f == other.f and self.h < other.h)

class Graf:
    def __init__(self, matr, start, scopuri, h):
        self.matr = matr
        self.start = start
        self.scopuri = scopuri
        self.h = h

    def scop(self, informatieNod):
        return informatieNod in self.scopuri
    
    def estimeaza_h(self, infoNod):
        return self.h[infoNod]

    def succesori(self, nod):
        lSuccesori = []
        for infoSuccesor in range(len(self.matr)):
            if self.matr[nod.informatie][infoSuccesor] > 0 and not nod.inDrum(infoSuccesor):
                lSuccesori.append(NodArbore(infoSuccesor, nod.g + self.matr[nod.informatie][infoSuccesor], self.estimeaza_h(infoSuccesor), nod))
        return lSuccesori

    
m = [
[0, 3, 5, 10, 0, 0, 100],
[0, 0, 0, 4, 0, 0, 0],
[0, 0, 0, 4, 9, 3, 0],
[0, 3, 0, 0, 2, 0, 0],
[0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 4, 0, 5],
[0, 0, 3, 0, 0, 0, 0],
]
start = 0
scopuri = [4,6]
h = [0,1,6,2,0,3,0]

    
def aStarSolMultipleLista(gr, nsol = 2):
    coada = [NodArbore(gr.start)]
    while coada:
        nodCurent = coada.pop(0)
        if gr.scop(nodCurent.informatie):
            print(repr(nodCurent))
            nsol -= 1
            if nsol == 0:
                return
        coada += gr.succesori(nodCurent)
        coada.sort()


#3

def aStarSolMultiplePriorityQueue(gr, nsol = 2):
    coada = queue.PriorityQueue()
    coada.put(NodArbore(gr.start))
    
    while not coada.empty() and nsol > 0:
        nodCurent = coada.get()
        
        if gr.scop(nodCurent.informatie):
            print(repr(nodCurent))
            nsol -= 1

        succesori = gr.succesori(nodCurent)
        for succesor in succesori:
            coada.put((succesor))


gr = Graf(m, start, scopuri, h)

#3

#0.25s
print("Utilizând o listă ca și coadă de priorități ca lista:")
start_time = time.time()
aStarSolMultipleLista(gr, nsol=6)
print("Timpul de execuție:", 1000 * (time.time() - start_time))


#0.5s, deci aproape dublu
print("\nUtilizând queue.PriorityQueue:")
start_time = time.time()
aStarSolMultiplePriorityQueue(gr, nsol=6)
print("Timpul de execuție:", 1000 * (time.time() - start_time))


#4

def bin_search(listaNoduri, nodNou, ls, ld):
   if len(listaNoduri)==0:
       return 0
   if ls==ld:
       if nodNou<listaNoduri[ls]:
           return ls
       elif nodNou>listaNoduri[ls]:
           return ld+1
   else:
       mij=(ls+ld)//2
       if nodNou<listaNoduri[mij]:
           return bin_search(listaNoduri, nodNou, ls, mij)
       elif nodNou>listaNoduri[mij]:
           return bin_search(listaNoduri, nodNou, mij+1, ld)
           

def aStarSolMultiple2(gr, nsol=2):
    coada = [NodArbore(gr.start)]

    while coada:
        nodCurent = coada.pop(0)

        if gr.scop(nodCurent.informatie):
            print(repr(nodCurent))
            nsol -= 1
            if nsol == 0:
                return

        succesori = gr.succesori(nodCurent)

        for succesor in succesori:
            index = bin_search(coada, succesor, 0, len(coada) - 1)
            coada.insert(index, succesor)


print("\nA* utilizand binary search:\n")
aStarSolMultiple2(gr, nsol=6)



def aStar(gr):
    open = [NodArbore(gr.start)]
    closed = []
    while open:
        nodCurent = open.pop(0)
        closed.append(nodCurent)
        if gr.scop(nodCurent.informatie):
            print(repr(nodCurent))
            return

        lSuccesori = gr.succesori(nodCurent)
        
        for s in lSuccesori:
            gasitOpen = False
            for nodC in open:
                if nodC.informatie == s.informatie:
                    gasitOpen = True
                    if nodC < s:
                        lSuccesori.remove(s)
                    else:
                        open.remove(nodC)
                    break
            if not gasitOpen:
                for nodC in closed:
                    if nodC.informatie == s.informatie:
                        gasitOpen = True
                        if nodC < s:
                            lSuccesori.remove(s)
                        else:
                            closed.remove(nodC)
                        break

        open += lSuccesori
        open.sort()
        
print("\n")
aStar(gr)