import Data.Char
--1
f1 :: [Int] -> Int
f1 [] = 0
f1 [x] = 0
f1 (x:y:xs) = if (mod x 3 == 0) && (mod y 3 == 0)
                then (x - y) + f1 (y:xs)
                else (x * y) + f1 (y:xs)

--2
nrVoc :: String -> Int
nrVoc xs = sum [1 | x <- xs, x `elem` "aeiouAEIOU"]

nrCons :: String -> Int
nrCons xs = length $ filter (`elem` "bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ") xs

f2 :: [String] -> Int -> Bool
f2 [] _ = True
f2 (x:xs) nr = if length x > nr
                then
                    (nrVoc x == nrCons x) && f2 xs nr
                else f2 xs nr

--3
sumPare :: [Int] -> Int
sumPare [] = 0
sumPare (x:xs) = if even x then x + sumPare xs else sumPare xs

f3 :: [[Int]] -> Int
f3 = foldr ((*) . sumPare) 1

--4

f4 :: [String] ->String -> Bool
f4 [] _ = True
f4 (x:xs) str
    | take (length str) x == str && even (length x) = f4 xs str
    | take (length str) x /= str = f4 xs str
    | otherwise = False

--5
type Name = String
type Def = String
data Dictionar = I Name Def
                | Ld Name [Dictionar]
                deriving Show


d1 = Ld "animal" [Ld "mamifer" [I "elefant" "acesta e un elefant", I "caine" "acesta este un caine", I "pisica" "aceasta este o pisica"], I "animale domestice" "definitie"]
d2 = Ld "Animal" [Ld "Mamifer" [I "Elefant" "acesta e un elefant",I "calne" "acesta este un caine",I "piSIca" "aceasta este o pisica"],I "animale domestice" "definitie"]
d3 = Ld "animal" [Ld "mamifer" [I "elefant" "Acesta e un Elefant", I "caine" "acesta este un caine", I "pisica" "aceasta este o pisica"], I "animale domestice" "definitie"]

--5a
f5a :: Dictionar -> [Name]
f5a (I n d) = [n]
f5a (Ld n dict) = concatMap f5a dict

--5b
instance Eq Dictionar where
  (I title1 def1) == (I title2 def2) = map toLower title1 == map toLower title2 && def1 == def2
  (Ld title1 entries1) == (Ld title2 entries2) = map toLower title1 == map toLower title2 && entries1 == entries2
  _ == _ = False

--6 
divBy3 :: [Int] -> Bool
divBy3 list = filter (\x -> mod x 3 == 0) list == list

howMany :: [[Int]] -> Int
howMany [] = 0
howMany (x:xs) = if divBy3 x then 1 + howMany xs else howMany xs

f6 :: [[Int]] -> Int -> Int -> Bool
f6 [] _ _ = True
f6 xs m n
  | m >= n &&  howMany xs >= n && howMany xs <= m = True
  | m < n &&  howMany xs >= m && howMany xs <= n = True
  | otherwise = False

--7
data Tree = Empty 
  | Node Int Tree Tree Tree -- arbore vid cu valoare de tip Int in radacina si 3 fii

extree :: Tree
extree = Node 4 (Node 5 Empty Empty Empty) (Node 3 Empty Empty (Node 1 Empty Empty Empty)) Empty

class ArbInfo t where
  level :: t-> Int -- intoarce inaltimea arborelui; pt un arbore vid se considera ca are inaltimea 0
  sumval:: t -> Int -- intoarce suma valorilor din arbore
  nrFrunze :: t -> Int -- intoarce nr de frunze al arborelui



instance ArbInfo Tree where 
  level Empty = 0 
  level (Node r t1 t2 t3) = 1 + max (max (level t1) (level t2)) (level t3)

  sumval Empty = 0
  sumval (Node r t1 t2 t3) =  r + sumval t1 + sumval t2 + sumval t3 

  nrFrunze Empty = 0 
  nrFrunze (Node _ Empty Empty Empty) = 1 
  nrFrunze (Node r t1 t2 t3) = nrFrunze t1 + nrFrunze t2 + nrFrunze t3
