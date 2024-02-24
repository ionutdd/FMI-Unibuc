--foldr -> arbore la dreapta
--foldl -> arbore la stanga

{-
foldr (-) 0 [1,2,3,4] = (1 - (2 - (3 - (4 - 0)))) = -2    -> in loc de - putem face o fct lambda sau whatever
foldl (-) 0 [1,2,3,4] = ((((0 - 1) -2) - 3) - 4) = -10

--la functiile comutative foldl si foldr dau acelasi rezultat


ghci> foldl (++) "first" ["abc","def","ghi"]
"firstabcdefghi"
ghci> foldr (++) "last" ["abc","def","ghi"]
"abcdefghilast"
-}


--in terminal :t foldr si :t foldl

--1

sumPatrImpare :: [Int] -> Int
sumPatrImpare = foldr (\x acc -> if  mod x 2 == 1 then acc + x * x else  acc) 0 



--2

allTrue :: [Bool] -> Bool
allTrue = foldr (&&) True


--3 

allVerifies :: (Int -> Bool) -> [Int] -> Bool
allVerifies funct = foldr (\x acc -> funct x && acc) True


--4

atLeastOneVerifies :: (Int -> Bool) -> [Int] -> Bool
atLeastOneVerifies funct = foldr (\x acc -> funct x || acc) False



--5

mapFoldr :: (a -> b) -> [a] -> [b]
mapFoldr funct = foldr (\x acc -> funct x : acc) []

filterFoldr :: (a -> Bool) -> [a] -> [a]
filterFoldr funct = foldr (\x acc -> if funct x then x : acc else acc) []


--6

listToInt :: [Integer] -> Integer
listToInt = foldl (\acc x -> acc * 10 + x) 0


--7

--7a)
rmChar :: Char -> String -> String
rmChar ch = foldr (\x acc -> if x /= ch then x : acc else acc ) ""   --asa e diferit

--7b) 

rmCharsRec :: String -> String -> String
rmCharsRec "" st2 = st2
rmCharsRec (x:xs) st2 = rmCharsRec xs (rmChar x st2)

--7c)                                                    --efectiv magie

rmCharsFold :: String -> String -> String
rmCharsFold st1 st2 = foldr rmChar st2 st1

--8

myReverse :: [Int] -> [Int]
myReverse = foldr (\x acc -> acc ++ [x]) []    --sau cu where myReverse = foldr f e l
                                                            --          where f x r = r ++ [x]
                                                            --                 e = []          


--9

myElem :: Int -> [Int] -> Bool
myElem el = foldr (\x acc -> if el == x then acc || True else acc) False



--10

myUnzip :: [(a, b)] -> ([a], [b])
myUnzip = foldr (\(x, y) (xs, ys) -> (x : xs, y : ys)) ([], [])


--11

helper :: Int -> [Int] -> [Int]
helper el list = if el `elem` list then list else el : list


union :: [Int] -> [Int] -> [Int]
union = foldr helper 


--12

helper2 :: Int -> [Int] -> [Int]
helper2 el = foldr (\x acc -> if el == x then x : acc else acc) [] 

intersect :: [Int] -> [Int] -> [Int]
intersect xs ys = foldr (\x acc -> helper2 x ys ++ acc) [] xs


