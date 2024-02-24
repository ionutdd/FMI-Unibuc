{- Monada Maybe este definita in GHC.Base 

instance Monad Maybe where
  return = Just
  Just va  >>= k   = k va
  Nothing >>= _   = Nothing


instance Applicative Maybe where
  pure = return
  mf <*> ma = do
    f <- mf
    va <- ma
    return (f va)       

instance Functor Maybe where              
  fmap f ma = pure f <*> ma   
-}

{-
safeDivide :: Double -> Double -> Maybe Double
safeDivide _ 0 = Nothing
safeDivide x y = Just (x / y)

addOne :: Double -> Maybe Double
addOne x = Just (x + 1)

-- Compoziție folosind bind operator (>>=)
divideAndAddOne :: Double -> Double -> Maybe Double
divideAndAddOne x y = do
  result1 <- safeDivide x y
  result2 <- addOne result1
  return result2

divideAndAddOne :: Double -> Double -> Maybe Double
divideAndAddOne x y =
  safeDivide x y >>= (\result1 -> addOne result1 >>= (\result2 -> return result2))
  --valoare de tip Maybe Double (safeDivide x y)
  --functie care ia valoarea result1 si produce rezultat de tipul Maybe Double

-}

--1
pos :: Int -> Bool
pos  x = if (x>=0) then True else False

fct :: Maybe Int ->  Maybe Bool
fct  mx =  mx  >>= (\x -> Just (pos x))

fct2 :: Maybe Int ->  Maybe Bool
fct2 mx = do 
  x <- mx
  return (pos x)

{- prin intermediul sintaxei do, extragem valoarea x din 
monadă și aplicăm funcția pos asupra acestei valori, în final împachetând rezultatul într-un Maybe Bool.
-}

--2a
addM :: Maybe Int -> Maybe Int -> Maybe Int
addM (Just x) (Just y) = Just $ x + y 
addM _ _ = Nothing

--2b
addM2 :: Maybe Int -> Maybe Int -> Maybe Int
addM2 mx my = do 
  x <- mx 
  y <- my 
  return (x+y)

--3a
cartesian_product xs ys = xs >>= ( \x -> (ys >>= \y-> return (x,y)))

cartesian_product2 xs ys = do 
  x <- xs 
  y <- ys 
  return (x,y)

--3b
prod f xs ys = [f x y | x <- xs, y<-ys]

prod2 f xs ys = do 
  x <- xs 
  y <- ys
  return (f x y)


--3c
myGetLine :: IO String
myGetLine = getChar >>= \x ->
      if x == '\n' then
          return []
      else
          myGetLine >>= \xs -> return (x:xs)

myGetLine2 :: IO String
myGetLine2 = do
  x <- getChar
  if x == '\n' then
    return []
  else do
    xs <- myGetLine2
    return (x:xs)


--4
prelNo noin = sqrt noin

ioNumber = do
     noin  <- readLn :: IO Float
     putStrLn $ "Intrare\n" ++ (show noin)
     let  noout = prelNo noin
     putStrLn $ "Iesire"
     print noout

ioNumberDo = (readLn :: IO Float) >>= \ noin -> ( putStrLn ("Intrare\n" ++ (show noin))
     >> let  noout = prelNo noin in  putStrLn "Iesire" >>
     print noout)

-- >>= pentru a lega readLn la noin, apoi folosește >> pentru a secvenția 
--restul acțiunilor monadice

--6a
data Person = Person { name :: String, age :: Int }

showPersonN :: Person -> String
showPersonN (Person n _) = "NAME: " ++ n

showPersonA :: Person -> String
showPersonA (Person _ a) = "AGE: " ++ show a

{-
showPersonN $ Person "ada" 20
"NAME: ada"
showPersonA $ Person "ada" 20
"AGE: 20"
-}
--6b
showPerson :: Person -> String
showPerson p = "(" ++ showPersonN p ++ ", " ++ showPersonA p ++ ")"

{-
showPerson $ Person "ada" 20
"(NAME: ada, AGE: 20)"
-}

newtype Reader env a = Reader { runReader :: env -> a }


instance Monad (Reader env) where
  return x = Reader (\_ -> x)
  ma >>= k = Reader f
    where f env = let a = runReader ma env
                  in  runReader (k a) env

--6c
mshowPersonN :: Reader Person String
mshowPersonN = Reader (\p -> "NAME: " ++ name p)

mshowPersonA :: Reader Person String
mshowPersonA = Reader (\p -> "AGE: " ++ show (age p))

mshowPerson :: Reader Person String
mshowPerson = do
  n <- mshowPersonN
  a <- mshowPersonA
  return $ "(" ++ n ++ "," ++ a ++ ")"

----
instance Applicative (Reader env) where
  pure = return
  mf <*> ma = do
    f <- mf
    a <- ma
    return (f a)       

instance Functor (Reader env) where              
  fmap f ma = pure f <*> ma    

{-
runReader mshowPersonN  $ Person "ada" 20
"NAME:ada"
runReader mshowPersonA  $ Person "ada" 20
"AGE:20"
runReader mshowPerson  $ Person "ada" 20
"(NAME:ada,AGE:20)" -}