import Distribution.Simple.Utils (xargs)
--Recap
--data Three a b = Three a b b 
--instance Functor (Three a) where
--fmap f (Three a b1 b2) = Three a (f b1) (f b2)



--Monade

--Functorii si aplicative functorii nu sunt monade, dar o monada e un functor si un aplicative functor

safeDivide :: Double -> Double -> Maybe Double
safeDivide _ 0 = Nothing
safeDivide x y = Just (x / y)

addOne :: Double -> Maybe Double
addOne x = Just (x + 1)

--divide and add One (varianta complicata)
daO :: Double -> Double -> Maybe Double
daO x y = safeDivide x y >>= (\result1->addOne result1 >>= (\result2 -> return result2))

--varianta simpla
daO x y = do
    result1 <- safeDivide x y
    result2 <- addOne result1
    return result2

--Exercitiul 1
pos :: Int -> Bool
pos x = if (x >= 0) then True else False
fct :: Maybe Int -> Maybe Bool
fct mx = do
    x <- mx --mx e maybe int, asa ca trebuie sa il despachetam in x care e acum int
    return (pos x)    --return impacheteaza la loc sa avem Maybe Bool

--Exercitiul 2
--a
addM :: Maybe Int -> Maybe Int -> Maybe Int
addM (Just x) (Just y) = Just (x + y)
addM _ _ = Nothing

--b

addM x y = do
    xx <- x
    yy <- y
    return (xx + yy)


--Exercitiul 3

cartesian_product :: Monad m => m a -> m b -> m (a, b)
cartesian_product xs ys = do
    x <- xs
    y <- ys
    return (x, y)


prod :: Monad m => (a -> b -> c) -> m a -> m b -> m c
prod f xs ys = do
    x <- xs
    y <- ys
    return (f x y)

myGetLine :: IO String  --citeste de la tastatura deci n-are parametru
myGetLine = do
    x <- getChar --ce primim de la tastatura
    if (x == '\n') then
        return []
    else
        do
        xs <- myGetLine
        return (x:xs)


--Exercitiul 4

--cu secventiere e cu >>=   (and then)         >> then
-- m >> n (2 monade) 
-- m >>= (\ fct lambda)


prelNo noin = sqrt noin
ioNumberDo = (readLn::IO Float) >>= \noin -> (putStrLn ("Intrare\n" ++ (show noin)) >> let noout = prelNo noin in putStrLn "Iesire" >> print noout)


--Exercitiul 6
--a

data Person = Person { name :: String, age :: Int }

showPersonN :: Person -> String
showPersonN (Person n a) = "NAME: " ++ n

showPersonA :: Person -> String
showPersonA (Person n a) = "Age: " ++ show a

--b

showPerson :: Person -> String
showPerson (Person n a) = "(" ++ showPersonN (Person n a) ++ "," ++ showPersonA (Person n a) ++ ")"

--c

newtype Reader env a = Reader { runReader :: env -> a }

instance Monad (Reader env) where
  return x = Reader (\_ -> x)
  ma >>= k = Reader f
    where f env = let a = runReader ma env
                  in  runReader (k a) env

instance Applicative (Reader env) where
  pure = return
  mf <*> ma = do
    f <- mf
    a <- ma
    return (f a)

instance Functor (Reader env) where
  fmap f ma = pure f <*> ma


mShowPersonN :: Reader Person String
mShowPersonN = Reader (\p -> "NAME: " ++ name p)

mShowPersonA :: Reader Person String
mShowPersonA = Reader (\p -> "AGE: " ++ show (age p))

mShowPerson :: Reader Person String
mShowPerson = do
    n <- mShowPersonN
    a <- mShowPersonA
    return $ "(" -- continuarea





--Exercitii de examen 


--1
f :: [Int] -> Int
f [] = 0
f [x] = 0
f (x:y:xs) = if x `mod` 3 == 0 && y `mod` 3 == 0 then x - y + f (y:xs) else x * y + f (y:xs)


--2
countVoc :: String -> Int
countVoc [] = 0
countVoc (x:xs) = if x == 'a' || x == 'e' || x == 'i' || x == 'o' || x == 'u' then 1 + countVoc xs else countVoc xs

countConst :: String -> Int
countConst [] = 0
countConst (x:xs) = if x == 'b' || x == 'c' || x == 'd' || x == 'f' || x == 'g' || x == 'h' || x == 'j' || x == 'k' || x == 'l' || x == 'm' || x == 'n' || x == 'p' || x == 'q' || x == 'r' || x == 's' || x == 't' || x == 'v' || x == 'w' || x == 'x' || x == 'y' || x == 'z' then 1 + countConst xs else countConst xs

f2 :: [String] -> Int -> Bool
f2 [] _ = True
f2 (x:xs) a = if length x <= a then True && (f2 xs a) else if countVoc x /= countConst x then False && (f2 xs a) else True && (f2 xs a)

--3
aux :: [Int] -> Int
aux [] = 0
aux (x:xs) = if (x `mod` 2) == 0 then x + aux xs else aux xs

f3 :: [[Int]] -> Int
f3 [] = 1
f3 (x:xs) = aux x * f3 xs