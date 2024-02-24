data Expr = Const Int -- integer constant
          | Expr :+: Expr -- addition
          | Expr :*: Expr -- multiplication
           deriving Eq

data Operation = Add | Mult deriving (Eq, Show)

data Tree = Lf Int -- leaf
          | Node Operation Tree Tree -- branch
           deriving (Eq, Show)

instance Show Expr where
  show (Const x) = show x
  show (e1 :+: e2) = "(" ++ show e1 ++ " + "++ show e2 ++ ")"
  show (e1 :*: e2) = "(" ++ show e1 ++ " * "++ show e2 ++ ")"


--1

evalExp :: Expr -> Int
evalExp (Const c) = c  --cazul de const
evalExp (e1 :+: e2) = evalExp e1 + evalExp e2
evalExp (e1 :*: e2) = evalExp e1 * evalExp e2

--test case
exp1 = ((Const 2 :*: Const 3) :+: (Const 0 :*: Const 5))



--2

evalArb :: Tree -> Int
evalArb (Lf leaf) = leaf
evalArb (Node Add tree1 tree2) = evalArb tree1 + evalArb tree2
evalArb (Node Mult tree1 tree2) = evalArb tree1 * evalArb tree2


--test case
arb1 = Node Add (Node Mult (Lf 2) (Lf 3)) (Node Mult (Lf 0) (Lf 5))




--3

expToArb :: Expr -> Tree
expToArb (Const cst) = Lf cst
expToArb (e1 :+: e2) = Node Add (expToArb e1) (expToArb e2)
expToArb (e1 :*: e2) = Node Mult (expToArb e1) (expToArb e2)
--exp1 e un bun test case



--4 (ABC)

data IntSearchTree value
  = Empty
  | BNode
      (IntSearchTree value)     -- elemente cu cheia mai mica
      Int                       -- cheia elementului
      (Maybe value)             -- valoarea elementului
      (IntSearchTree value)     -- elemente cu cheia mai mare

lookup1 :: Int -> IntSearchTree value -> Maybe value
lookup1 cheie Empty = Nothing
lookup1 cheie (BNode t1 ckey cVal t2)
  | cheie == ckey = cVal
  | cheie < ckey = lookup1 cheie t1
  | otherwise = lookup1 cheie t2


--test case
testtree =
        BNode
          (BNode Empty 2 (Just "Two") Empty)
          5
          (Just "Five")
          (BNode Empty 8 (Just "Eight") Empty)


--ex 5

keys :: IntSearchTree value -> [Int]
keys Empty = []
keys (BNode t1 ckey cval t2) = keys t1 ++ [ckey]  ++ keys t2


--ex 6

values :: IntSearchTree value -> [Maybe value]
values Empty = []
values (BNode t1 ckey cval t2) = values t1 ++ [cval] ++ values t2

--ex 7

insert :: Int -> value -> IntSearchTree value -> IntSearchTree value
insert cheie val Empty = BNode Empty cheie (Just val) Empty
insert cheie val (BNode t1 ckey cval t2)
    | cheie == ckey = BNode t1 cheie (Just val) t2
    | cheie < ckey = BNode (insert cheie val t1) ckey cval t2
    | cheie > ckey = BNode t1 ckey cval (insert cheie val t2)

--apelam cu values insertTree
insertTree = insert 1 "One" testtree

--ex 8

delete :: Int -> IntSearchTree value -> IntSearchTree value
delete cheie Empty = BNode Empty cheie Nothing Empty
delete cheie (BNode t1 ckey cval t2)
    | cheie == ckey = BNode t1 cheie Nothing t2
    | cheie < ckey = BNode (delete cheie t1) ckey cval t2
    | cheie > ckey = BNode t1 ckey cval (delete cheie t2)

--apelam cu values deleteTree
deleteTree = delete 2 testtree


--ex 9

toList :: IntSearchTree value -> [(Int, Maybe value)]
toList Empty = []
toList (BNode t1 ckey Nothing t2) = toList t1 ++ toList t2
toList (BNode t1 ckey cval t2) = toList t1 ++ [(ckey, cval)] ++ toList t2

--ex 10 

fromList :: [(Int, value)] -> IntSearchTree value
fromList [] = Empty
fromList ((cheie,val):xs) = insert cheie val (fromList xs)


--apelam cu values listTree
testfromList = [(2, "Two"),(5, "Five"),(8, "Eight")]
listTree = fromList testfromList


--ex 11

printTree :: IntSearchTree value -> String
printTree Empty = ""
printTree (BNode t1 ckey value t2) = printTree t1 ++ show ckey ++ " " ++ printTree t2