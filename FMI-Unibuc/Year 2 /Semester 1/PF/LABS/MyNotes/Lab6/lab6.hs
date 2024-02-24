--cream clasa Fruct

data Fruct
  = Mar String Bool
  | Portocala String Int

--intializam Fructe 
ionatanFaraVierme = Mar "Ionatan" False
goldenCuVierme = Mar "Golden Delicious" True
portocalaSicilia10 = Portocala "Sanguinello" 10
listaFructe = [Mar "Ionatan" False,
                Portocala "Sanguinello" 10,
                Portocala "Valencia" 22,
                Mar "Golden Delicious" True,
                Portocala "Sanguinello" 15,
                Portocala "Moro" 12,
                Portocala "Tarocco" 3,
                Portocala "Moro" 12,
                Portocala "Valencia" 2,
                Mar "Golden Delicious" False,
                Mar "Golden" False,
                Mar "Golden" True]

--ex 1
--a)

ePortocalaDeSicilia :: Fruct -> Bool
ePortocalaDeSicilia (Portocala nume ceva) = nume == "Tarocco" || nume == "Moro" || nume == "Sanguinello"
ePortocalaDeSicilia (Mar _ _) = False

--b) 

nrFeliiSicilia :: [Fruct] -> Int
nrFeliiSicilia [] = 0
nrFeliiSicilia ((Mar _ _):xs) = nrFeliiSicilia xs
nrFeliiSicilia ((Portocala nume nr): xs) =  nr + nrFeliiSicilia xs

--c)

nrMereViermi :: [Fruct] -> Int
nrMereViermi [] = 0
nrMereViermi ((Portocala _ _):xs) = nrMereViermi xs
nrMereViermi ((Mar ceva bool): xs) = if bool then 1 + nrMereViermi xs else nrMereViermi xs




--ex 2

--a)
type NumeA = String
type Rasa = String
data Animal = Pisica NumeA | Caine NumeA Rasa
    deriving Show   --un fel de mostenire, show are chestii de afisare pe ecran 


vorbeste :: Animal -> String
vorbeste (Pisica nume) = "Meow!"
vorbeste (Caine nume rasa) = "Woof!"

--b)

rasa :: Animal -> Maybe String
rasa (Caine numa rasa) = Just rasa
rasa (Pisica nume) = Nothing


--ex 3

--a)
data Linie = L [Int]
    deriving Show
data Matrice = M [Linie]
    deriving Show


verifica :: Matrice -> Int -> Bool
verifica (M []) _ = True
verifica (M (L l:ls)) n = foldr (+) 0 l == n && verifica (M ls) n


--b) 

pozitive :: [Int] -> Bool
pozitive [] = True
pozitive (x:xs) = x >= 0 && pozitive xs


doarPozN :: Matrice -> Int -> Bool
doarPozN (M []) _ = True
doarPozN (M (L l:ls)) n = if length l == n then pozitive l && doarPozN (M ls) n else doarPozN (M ls) n


--c)

corect :: Matrice -> Bool
corect (M []) = True -- 0 liste
corect (M [l]) = True -- o singura lista
corect (M((L l1):(L l2):ls)) = if length l1 == length l2 then corect (M ls) else False