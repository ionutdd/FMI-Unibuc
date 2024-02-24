--1 
{-# OPTIONS_GHC -Wno-overlapping-patterns #-}
import Data.Char 
import Data.List (permutations)
import Data.List (delete)

palindrom :: String -> Bool
palindrom word = word == reverse word 

isVoc :: Char -> Bool
isVoc letter = elem letter "aeiouAEIOU"

nrVoc :: String -> Int
nrVoc "" = 0
nrVoc (t:h) = if isVoc t == True then 1 + nrVoc h else nrVoc h

nrVocale :: [String] -> Int
nrVocale [] = 0
nrVocale (t:h) = if palindrom t then nrVoc t + nrVocale h else nrVocale h


--2 

f :: Int -> [Int] -> [Int]
f _ [] = []
f x (t:h) = if t `mod` 2 == 0 then t : x : f x h else t : f x h



--3 

divizori :: Int -> [Int]
divizori n = [x | x <- [1..n], n `mod` x == 0]



--4

listadiv :: [Int] -> [[Int]]
listadiv lista = [divizori x | x <- lista]


--5a 

inIntervalRec :: Int -> Int -> [Int] -> [Int]
inIntervalRec _ _ [] = []
inIntervalRec x y (t:h) = if t >= x && t <= y then t : inIntervalRec x y h else inIntervalRec x y h


--5b

inIntervalComp :: Int -> Int -> [Int] -> [Int]
inIntervalComp x y list = [z | z <- list, z >= x, z <= y]




--6a

pozitiveRec :: [Int] -> Int
pozitiveRec [] = 0
pozitiveRec (h:t) = if h > 0 then 1 + pozitiveRec t else pozitiveRec t


--6b

pozitiveComp :: [Int] -> Int
pozitiveComp list = length [x | x <- list, x > 0]


--7a

fct :: Int -> [Int] -> [Int]
fct _ [] = []
fct i (x:xs) = if x `mod` 2 == 1 then i : fct (i + 1) xs else fct (i + 1) xs

pozitiiImpareRec :: [Int] -> [Int]
pozitiiImpareRec list = fct 0 list

--7b
pozitiiImpareComp :: [Int] -> [Int]
pozitiiImpareComp list = [poz | (poz,x) <- zip [0..length list] list, x `mod` 2 == 1]

--8a

multDigitsRec :: String -> Int 
multDigitsRec [] = 1
multDigitsRec (t:h) = if isDigit t then digitToInt t * multDigitsRec h else multDigitsRec h


--8b

multDigitsComp :: String -> Int
multDigitsComp word = product [digitToInt ch | ch <-word, isDigit ch]


--Extras
--9 permutari

permut :: [Int] -> [[Int]]
permut list = permutations list



--10 combinari de k 

combinari :: Int -> [Int] -> [[Int]]

combinari 0 _  = [[]] 
combinari _ [] = []  

combinari k (x:xs) = map (x:) (combinari (k-1) xs) ++ combinari k xs



--11 aranjamente de k 

aranjamente :: Int -> [Int] -> [[Int]]
aranjamente 0 _ = [[]] 
aranjamente _ [] = []
aranjamente k l = [x:xs | x <- l, xs <- aranjamente (k-1) (delete x l)]