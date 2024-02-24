--Ex 1

poly :: Double -> Double -> Double -> Double -> Double;
poly a b c x = a * x * x + b * x + c


--Ex 2

eeny :: Integer -> String
eeny x = if (even x) then "eeny" else "meeny"

--Ex 3

--varianta cu if-uri
-- fizzbuzz :: Integer -> String
-- fizzbuzz x = if (mod x 15 == 0) then "FizzBuzz" else if (mod x 3 == 0) then "Fizz" else if (mod x 5 == 0) then "Buzz" else ""


--varianta cu garzi

fizzbuzz :: Integer -> String
fizzbuzz x 
           | (mod x 15 == 0)  = "FizzBuzz"
           | (mod x 3 == 0) = "Fizz"
           | (mod x 5 == 0) = "Buzz"
           | otherwise = ""


--Fibonacci 

--varianta 1 cu garzi

-- fibonacciCazuri :: Integer -> Integer
-- fibonacciCazuri n
--                     | n < 2 = n
--                     | otherwise = fibonacciCazuri (n - 1) + fibonacciCazuri (n - 2)

fibonacciEcuational :: Integer -> Integer
fibonacciEcuational 0 = 0
fibonacciEcuational 1 = 1
fibonacciEcuational n =
                        fibonacciEcuational (n - 1) + fibonacciEcuational (n - 2)


--Tribonacci

--varianta 1 cu garzi

-- tribonacci :: Integer -> Integer
-- tribonacci n 
--                 | n < 3 = 1
--                 | n == 3 = 2
--                 | otherwise = tribonacci (n - 1) + tribonacci (n - 2) + tribonacci (n - 3)


--varianta 2 ecuationala 

tribonacci :: Integer -> Integer
tribonacci 1 = 1
tribonacci 2 = 1
tribonacci 3 = 2
tribonacci n =
                tribonacci (n - 1) + tribonacci (n - 2) + tribonacci (n - 3)



--Gasiti valoarea pentru binomial (ex5)

binomial :: Integer -> Integer -> Integer
binomial _ 0 = 1
binomial 0 _ = 0
binomial n k = 
                binomial (n - 1) k + binomial (n - 1) (k - 1)


--verifL - verifică dacă lungimea unei liste date ca parametru este pară. (6a)

verifl :: [Int] -> Bool
verifl x = even (length x) 


--takefinal - pentru o listă l dată ca parametru s, i un număr n, întoarce o listă care cont, ine ultimele n elemente ale listei l. Dacă lista are mai put, in de n elemente, întoarce lista nemodificată. (6b)

takefinal :: [a] -> Int -> [a]   --acum merge si cu siruri de caractere, cand facem cu Int mergea doar cu Int
takefinal l n  
                | length l <= n = l
                | otherwise = drop n l

--remove - pentru o listă s, i un număr n, întoarce lista primită ca parametru din care se s, terge elementul de pe pozit, ia n. (Hint: putet, i folosi funct, iile take s, i drop). Scriet, i s, i prototipul funct, iei. (6c)

remove :: [Int] -> Int -> [Int]
remove l n = take (n - 1) l ++ drop (length l - n + 1) l



semiPareRec :: [Int] -> [Int]
semiPareRec [] = []
semiPareRec (h:t)
        | even h = h `div` 2 : t'
        | otherwise = t'
        where t' = semiPareRec t


--ex7a myreplicate

myreplicate :: Int -> Int -> [Int]
myreplicate 0 _ = []
myreplicate n v = [v] ++ myreplicate (n - 1) v

--7b sumImp

sumImp :: [Int] -> Int
sumImp [] = 0
sumImp (h:t) 
            | even h = t'
            | otherwise = h + t'
            where t' = sumImp t

--7c totalLen

totalLen :: [String] -> Int
totalLen [] = 0
totalLen (h:t) 
               | h !! 0 == 'A' = length h + totalLen t
               | otherwise = totalLen t