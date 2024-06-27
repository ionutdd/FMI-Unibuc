import copy

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
    def __init__(self, start, scopuri):
        self.start = start
        self.scopuri = scopuri

    def scop(self, informatieNod):
        return informatieNod in self.scopuri
    
    def valideaza(self):
        matriceDesfasurata = self.start[0] + self.start[1] + self.start[2]
        nrInversiuni = 0
        for i, placuta1 in enumerate(matriceDesfasurata):
            for placuta2 in matriceDesfasurata[i + 1:]:
                if placuta1 > placuta2 and placuta2:
                    nrInversiuni += 1
        
        return nrInversiuni % 2 == 0

    def estimeaza_h(self, infoNod, euristica):
        if self.scop(infoNod):
            return 0
        
        if euristica == "banala":
            return 1
        if euristica == "euristica mutari":
            minH = float('inf')
            for scop in self.scopuri:
                h = 0
                #3 aici se modifica cu distanta manhattan
                for iLinie, linie in enumerate(scop):
                    for iPlacuta, placuta in enumerate(linie):
                        if infoNod[iLinie][iPlacuta] != placuta:
                            h += 1

                if h < minH:
                    minH = h
            return minH

    def succesori(self, nod, euristica):

        def gasesteGol(matr):
            for l in range(3):
                for c in range(3):
                    if matr[l][c] == 0:
                        return l, c

        lSuccesori = []
        lGol, cGol = gasesteGol(nod.informatie)
        directii = [[-1, 0], [1,0], [0, -1], [0, 1]]
        
        for d in directii:
            lPlacuta = lGol + d[0]
            cPlacuta = cGol + d[1]
            if not (0 <= lPlacuta <= 2 and 0 <= cPlacuta <= 2):
                continue

            infoSuccesor = copy.deepcopy(nod.informatie)
            infoSuccesor[lGol][cGol], infoSuccesor[lPlacuta][cPlacuta] = infoSuccesor[lPlacuta][cPlacuta], infoSuccesor[lGol][cGol]

            if not nod.inDrum(infoSuccesor):
                lSuccesori.append(NodArbore(infoSuccesor, nod.g + 1, self.estimeaza_h(infoSuccesor, euristica), nod))
        return lSuccesori
    
    
def aStar(gr, euristica):
    if not gr.valideaza():
        print("Nu avem solutii")
        return

    open = [NodArbore(gr.start)]
    closed = []
    while open:
        nodCurent = open.pop(0)
        closed.append(nodCurent)
        if gr.scop(nodCurent.informatie):
            print(repr(nodCurent))
            return

        lSuccesori = gr.succesori(nodCurent, euristica)
        
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
    print("Nu avem solutii")


f = open("input.txt", "r")
continut= f.read()
start = [list(map(int, linie.strip().split(" "))) for linie in continut.strip().split("\n")]
scopuri = [
    [[1,2,3],
     [4,5,6],
     [7,8,0]]
]
gr = Graf(start, scopuri)
aStar(gr, "euristica mutari")


# de facut 3c, 3d, 3e, 3f