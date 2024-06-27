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
    


    def afisSolFisier(self, fisier):
        noduri_drum = self.drumRadacina()
        for i in range(len(noduri_drum) - 1):
            nod_curent = noduri_drum[i]
            nod_urmator = noduri_drum[i + 1]

            if nod_urmator.informatie[2] == 1:
                directie = "(Stanga<barca>)"
                dinCeMal = "Dreapta"
            else:
                directie = "(Dreapta<barca>)"
                dinCeMal = "Stanga"

            dif_mis = abs(nod_curent.informatie[0] - nod_urmator.informatie[0])
            dif_can = abs(nod_curent.informatie[1] - nod_urmator.informatie[1])

            fisier.write(f">>> Barca s-a deplasat de la malul {dinCeMal}, {directie} cu {dif_can} canibali si {dif_mis} misionari.\n")
            fisier.write("(Stanga) {} canibali {} misionari  ......  (Dreapta) {} canibali  {} misionari\n\n".format(
                nod_urmator.informatie[1], nod_urmator.informatie[0],
                Graf.N - nod_urmator.informatie[1], Graf.N - nod_urmator.informatie[0]))


#2 clasa Graf
    
class Graf:
    def __init__(self, start, scopuri):
        self.start = start
        self.scopuri = scopuri

    def scop(self, informatieNod):
        return informatieNod in self.scopuri

    #mal curent = mal cu barca
    def succesori(self, nod):
        def testConditie(m, c):
            return m == 0 or m >= c
        
        lSuccesori = []

        if nod.informatie[2] == 1:
            misMalCurent = nod.informatie[0]
            canMalCurent = nod.informatie[1]
            misMalOpus = Graf.N - nod.informatie[0]
            canMalOpus = Graf.N - nod.informatie[1]
        else:
            misMalOpus = nod.informatie[0]
            canMalOpus = nod.informatie[1]
            misMalCurent = Graf.N - nod.informatie[0]
            canMalCurent = Graf.N - nod.informatie[1]

        maxMisBarca = min(misMalCurent, Graf.M)

        for mb in range(maxMisBarca + 1):
            if mb == 0:
                minCanBarca = 1
                maxCanBarca = min(canMalCurent, Graf.M)
            else:
                minCanBarca = 0
                maxCanBarca = min(canMalCurent, Graf.M - mb, mb)
            for cb in range(minCanBarca, maxCanBarca + 1):
                misMalCurentNou = misMalCurent - mb
                canMalCurentNou = canMalCurent - cb
                misMalOpusNou = misMalOpus + mb
                canMalOpusNou = canMalOpus + cb

                if not testConditie(misMalCurentNou, canMalCurentNou):
                    continue
                if not testConditie(misMalOpusNou, canMalOpusNou):
                    continue

                if nod.informatie[2] == 1:
                    infoSuccesor = (misMalCurentNou, canMalCurentNou, 0)
                else:
                    infoSuccesor = (misMalOpusNou, canMalOpusNou, 1)

                if not nod.inDrum(infoSuccesor):
                    lSuccesori.append(NodArbore(infoSuccesor, nod))

        return lSuccesori
    
def breadthFirst(gr, nsol = 2):
    coada = [NodArbore(gr.start)]
    solutii = []
    while coada:
        nodCurent = coada.pop(0)
        if gr.scop(nodCurent.informatie):
            solutii.append(nodCurent)
            print(repr(nodCurent))
            nsol -= 1
            if nsol == 0:
                return solutii
        coada += gr.succesori(nodCurent)
    
    return solutii

f = open("input.txt", "r")
[Graf.N, Graf.M] = f.readline().strip().split()
Graf.N = int(Graf.N)
Graf.M = int(Graf.M)

#(misionari mal initial, canibali mal initial, barca pe ce mal)
#pozitia barcii pe malul initial e 1, altfel pe malul final 0
start = (Graf.N, Graf.N, 1)
scopuri = [(0, 0, 0)]

gr = Graf(start, scopuri)
rezultate = breadthFirst(gr, nsol = 3)


#Exericitul 3

g = open("output.txt", "w")

k = 0

for solutie in rezultate:
    k += 1
    solutie.afisSolFisier(g)

    if k != len(rezultate):
        g.write("\n")
        g.write("\n")
        g.write("-----------------")
        g.write("Urmatoarea solutie\n")
        g.write("\n")
        g.write("\n")


g.close()



#Exercitiul 4

