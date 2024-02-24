--ex 2 

factori :: Int -> [Int]
factori n = [x | x <- [1..n], n `mod` x == 0]


--ex 3

prim :: Int -> Bool
prim n = length(factori n) == 2 



--ex 4

numerePrime :: Int -> [Int]
numerePrime n = [x | x <- [2..n], prim x]


--ex 5

myzip3 :: [a] -> [b] -> [c] -> [(a, b, c)]
myzip3 a b c = [(x,y,z) | (x, (y, z)) <- zip a (zip b c)]





--ex 6

firstEl :: [(a, b)] -> [a]
firstEl x = map fst x



--ex 7

sumList :: [[Int]] -> [Int]
sumList x = map sum x



--ex 8

prel2 :: [Int] -> [Int]
prel2 x = map (\y -> if y `mod` 2 == 1 then 2 * y else y `div` 2) x



--ex 9

contineChar :: Char -> [String] -> [String]
contineChar ch x = filter (elem ch) x



--ex 10

patrateleImparelor :: [Int] -> [Int]
patrateleImparelor = map (\y -> if y `mod` 2 == 1 then y * y else y)  -- se poate sa nu scriem deloc x adica lista



--ex 11

patratelePozitiilorImpare :: [Int] -> [Int]
patratelePozitiilorImpare a = map (\(x,y) -> x * x) (filter (\(x, y) -> y `mod` 2 == 1) (zip a [0..])) 




--ex 12

numaiVocale :: [String] -> [String]
numaiVocale = map (filter (\y -> elem y "aeiouAEIOU"))


--ex 13

mymap :: (a -> b) -> [a] -> [b]
mymap f [] = []
mymap f (x : xs) = f x : mymap f xs


myfilter :: (a -> Bool) -> [a] -> [a]
myfilter p [] = []
myfilter p (x:xs) | p x = x : myfilter p xs
                | otherwise = myfilter p xs