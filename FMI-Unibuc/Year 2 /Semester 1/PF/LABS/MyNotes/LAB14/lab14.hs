--1

data Arb = Empty | Node Int Arb Arb
            deriving Show

data Point = Pt [Int]
            deriving Show

class ToFromArb a where
    toArb :: a -> Arb
    fromArb :: Arb -> a

instance ToFromArb Point where
    toArb (Pt []) = Empty
    toArb (Pt (x:xs)) = Node x (toArb (Pt (filter(<x) xs))) (toArb (Pt (filter(>x) xs)))

    fromArb Empty = Pt []
    fromArb (Node x l r) = Pt (p1 ++ [x] ++ p2)
                      where
                            Pt p1 = fromArb l
                            Pt p2 = fromArb r


--2
--a)

getFromInterval :: Int -> Int -> [Int] -> [Int]
getFromInterval y z [] = []
getFromInterval y z (x:xs) = if x >= y && x <= z then [x] ++ getFromInterval y z xs else getFromInterval y z xs

--b) cu monade

getFromInterval2 :: Int -> Int -> [Int] -> [Int]
getFromInterval2 y z (x) = do
    a <- x 
    if a >= y && a <= z then return (a) else []


--3

newtype ReaderWriter env a = RW {getRW :: env-> (a,String)}

instance Monad (ReaderWriter env) where 
    return va = RW (\_ -> va, "")
    ma >>= k = RW f
        where f env = let (va, str1) = getRW ma env
                          (vb, str2) = getRW (k va) env
                      in (vb, str1 ++ str2)     

{-
k este o fct care primeste o valoare de tip a si intoarce o noua actiune monadica de ReadWriter env b.
Mai precis, k este o functie de tipul a -> ReadWriter env b.

ma este la randul ei o valoare de tipul ReadWriter env a

Compune 2 actiuni, in primul rand, se obtine rezultatul si log-ul primei actiuni (ma).
Apoi, se obtine rezultatul si log-ul celei de-a doua actiuni (k va).
Rezultatul final este compus din rezultatul celei de-a doua actiuni (vb) si concatenarea log-urilor
-}




--extra
data PairInt = P Int Int deriving Show
data MyList = L [PairInt] deriving Show

data Exp = I Int | Add Exp Exp | Mul Exp Exp deriving Show

class MyClass m where 
    toExp :: m -> Exp

instance MyClass MyList where 
    toExp (L []) = I 1
    toExp (L ((P x y):xs)) = Mul (Add (I x) (I y))(toExp (L xs))