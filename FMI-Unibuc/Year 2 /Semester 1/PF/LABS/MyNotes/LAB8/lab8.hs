{-# OPTIONS_GHC -Wno-overlapping-patterns #-}
import Data.Binary.Get (label)
class Collection c where
  empty :: c key value
  singleton :: key -> value -> c key value
  insert
      :: Ord key
      => key -> value -> c key value -> c key value
  clookup :: Ord key => key -> c key value -> Maybe value
  delete :: Ord key => key -> c key value -> c key value
  keys :: c key value -> [key]
  values :: c key value -> [value]
  toList :: c key value -> [(key, value)]
  fromList :: Ord key => [(key,value)] -> c key value

--1

  keys c = [fst p | p <- toList c]
  values c = [snd p | p <- toList c]
  fromList [] = empty
  fromList ((a,b):xs) = insert a b (fromList xs)

--2
  
newtype PairList k v
  = PairList { getPairList :: [(k, v)] }

instance Collection PairList where 
    empty = PairList[]

    singleton keys values = PairList [(keys, values)]

    insert keys values (PairList pair) = PairList ((keys, values) : filter((/= keys).fst) pair)

    clookup key = lookup key.getPairList

    delete key (PairList pair) = PairList(filter ((/= key).fst) pair)

    toList = getPairList 

-- 3

data SearchTree key value
  = Empty
  | BNode
      (SearchTree key value) -- elemente cu cheia mai mica
      key                    -- cheia elementului
      (Maybe value)          -- valoarea elementului
      (SearchTree key value) -- elemente cu cheia mai mare

instance Collection SearchTree where     
    empty = Empty

    singleton key value = BNode Empty key (Just value) Empty

    insert key value = go 
                       where 
                       go Empty = singleton key value 
                       go (BNode t1 k1 v1 t2)
                        | key == k1 = BNode t1 k1 (Just value) t2
                        | key < k1 = BNode (go t1) k1 v1 t2
                        | otherwise = BNode t1 k1 v1 (go t2)


    delete cheie Empty = BNode Empty cheie Nothing Empty
    delete cheie (BNode t1 ckey cval t2)
        | cheie == ckey = BNode t1 cheie Nothing t2
        | cheie < ckey = BNode (delete cheie t1) ckey cval t2
        | cheie > ckey = BNode t1 ckey cval (delete cheie t2)
    
    toList Empty = []
    toList (BNode t1 k Nothing t2) = toList t1 ++ toList t2
    toList (BNode t1 k v t2) = toList t1 ++ (g k v)  ++ toList t2 
                                        where 
                                            g k (Just v) = [(k,v)]
                                            g _ _ = []

    clookup cheie Empty = Nothing
    clookup cheie (BNode t1 ckey cVal t2)
        | cheie == ckey = cVal
        | cheie < ckey = clookup cheie t1
        | otherwise = clookup cheie t2


-- 4

data Punct = Pt [Int]

data Arb = Vid | F Int | N Arb Arb
          deriving Show

class ToFromArb a where
 	    toArb :: a -> Arb
	    fromArb :: Arb -> a

instance Show Punct where
    show(Pt []) = "()"
    show(Pt l) = "(" ++ (g l) ++ ")" where 
                                        g [] = ""
                                        g [x] = show x
                                        g (x:y:xs) = show x ++ "," ++ g (y:xs)

-- 5

instance ToFromArb Punct where
    toArb (Pt []) = Vid
    toArb (Pt (x:xs)) = N (F x) (toArb (Pt xs))
    
    fromArb Vid = Pt []
    fromArb (F x) = Pt [x]
    fromArb (N l r) = Pt (p1 ++ p2)
                      where 
                            Pt p1 = fromArb l
                            Pt p2 = fromArb r
                        
-- 6

data Geo a = Square a | Rectangle a a | Circle a
    deriving Show

class GeoOps g where
  perimeter :: (Floating a) => g a -> a
  area :: (Floating a) =>  g a -> a

instance GeoOps Geo where
    perimeter (Square a) = 4 * a
    perimeter (Rectangle a b) = 2 * a + 2 * b
    perimeter (Circle a) = 2 * pi * a

    area (Square a) = a * a
    area (Rectangle a b) = a * b
    area (Circle a) = pi * a * a


--7 

instance (Eq a, Floating a) => Eq (Geo a) where

    fig1 == fig2 = perimeter fig1 == perimeter fig2
