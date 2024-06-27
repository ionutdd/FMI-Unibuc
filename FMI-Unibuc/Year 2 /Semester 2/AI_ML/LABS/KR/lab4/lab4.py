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
    
    def cost_mutare(self, bloc_initial, bloc_final):
        if bloc_initial is None:  
            return ord(bloc_final) - ord('a') + 1
        else:
            return abs(ord(bloc_initial) - ord(bloc_final))
    
    def estimeaza_h(self, infoNod, euristica):
        if self.scop(infoNod):
            return 0
        
        if euristica == "banala":
            return 1
        if euristica == "euristica mutari":
            minH = float('inf')
            for scop in self.scopuri:
                h = 0
                for iStiva, stiva in enumerate(scop):
                    for iBloc, bloc in enumerate(stiva):
                        try:
                            if infoNod[iStiva][iBloc] != bloc:
                                h += 1
                        except:
                            h += 1

                if h < minH:
                    minH = h
            return minH
        
        if euristica == "euristica costuri":
            minCost = float('inf')
            for scop in self.scopuri:
                cost = 0
                for iStiva, stiva in enumerate(scop):
                    for iBloc, bloc in enumerate(stiva):
                        try:
                            if infoNod[iStiva][iBloc] != bloc:
                                cost += self.cost_mutare(infoNod[iStiva][iBloc], bloc)  
                        except IndexError:
                            cost += self.cost_mutare(None, bloc)  
                if cost < minCost:
                    minCost = cost
            return minCost 
        
        if euristica == "euristica neadmisibila":
            return float('inf')  
    

    def succesori(self, nod, euristica):
        lSuccesori = []
        for i, stiva in enumerate(nod.informatie):
            if not stiva:
                continue
            copieStive = copy.deepcopy(nod.informatie)
            bloc = copieStive[i].pop()

            for j in range(len(copieStive)):
                if i == j:
                    continue
                infoSuccesor = copy.deepcopy(copieStive)
                infoSuccesor[j].append(bloc)
        
                if not nod.inDrum(infoSuccesor):
                    lSuccesori.append(NodArbore(infoSuccesor, nod.g + 1, self.estimeaza_h(infoSuccesor, euristica), nod))
        return lSuccesori
    
def aStar(gr, euristica):
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

def calculeazaStive(sir):
    return [sirStiva.strip().split() if sirStiva != "#" else [] for sirStiva in sir.strip().split("\n")]


f = open("input.txt", "r")
sirStart, sirScopuri = f.read().split("=========")
start = calculeazaStive(sirStart)
scopuri = [calculeazaStive(sirScop) for sirScop in sirScopuri.split("---")]
gr = Graf(start, scopuri)

aStar(gr, "euristica mutari")
print()
#3
aStar(gr, "euristica costuri")
print()
aStar(gr, "euristica neadmisibila")
