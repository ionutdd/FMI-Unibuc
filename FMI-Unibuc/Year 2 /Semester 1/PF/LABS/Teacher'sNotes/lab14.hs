--S1
data Point = Pt [Int]
    deriving Show

data Arb = Empty | Node Int Arb Arb
    deriving Show

class ToFromArb a where
    toArb :: a -> Arb
    fromArb :: Arb -> a

instance ToFromArb Point where
    toArb (Pt []) = Empty
    toArb  (Pt (x:xs)) =  Node x (toArb (Pt (filter (< x) xs)))  (toArb (Pt (filter (>= x) xs)))

    fromArb Empty = Pt []
    fromArb (Node x t1 t2) = let Pt l1 = fromArb t1 
                                 Pt l2 = fromArb t2 
                            in Pt $ l1 ++ [x] ++ l2

--Sub2
--getFromInterval 5 7 [1..10] == [5,6,7]
getFromInterval :: Int -> Int -> [Int] -> [Int]
getFromInterval x y list = [z | z <- list, z >= x, z <=y]

getFromIntervalM :: Int -> Int -> [Int] -> [Int]
getFromIntervalM x y list = do 
    z <- list 
    if z >= x && z <= y then return z else []

--Sub3
newtype ReaderWriter env a = RW {getRW :: env-> (a,String)}

instance Monad (ReaderWriter env) where
  return va = RW (\_ -> (va,""))
  ma >>= k = RW f 
      where f env = let (va, str1) = getRW ma env
                        (vb, str2)  = getRW (k va) env
                    in (vb, str1 ++ str2)

{-
k este o funcție care primește o valoare de tip a și întoarce o nouă acțiune
 monadică de tipul 
ReaderWriter env b. 
Mai precis, k este o funcție de tipul a -> ReaderWriter env b.-}


--ma este la randul ei o valoare de tipul ReaderWriter env a
{-
Compune două acțiuni. În primul rând, se obține rezultatul și log-ul primei acțiuni (ma).
Apoi, se obține rezultatul și log-ul celei de-a doua acțiuni (k va). 
Rezultatul final este compus din rezultatul celei de-a doua acțiuni (vb) și 
concatenarea log-urilor.-}


{-Haskell necesită ca instanțele pentru superclase să fie, de asemenea, definite.-}
instance Applicative (ReaderWriter env) where
  pure = return
  mf <*> ma = do
    f <- mf
    va <- ma
    return (f va)    

{-
 Se descompune funcția din primul argument (mf) și valoarea din al doilea argument (ma). 
 Apoi, construiește o acțiune care aplică funcția asupra valorii și returnează rezultatul.-}       

instance Functor (ReaderWriter env) where              
  fmap f ma = pure f <*> ma  

{-Aplică funcția f asupra rezultatului acțiunii ma. 
Aceasta este implementată în termenii funcțiilor pure și <*>-}