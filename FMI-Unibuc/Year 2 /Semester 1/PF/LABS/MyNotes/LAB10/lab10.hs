import Data.List (nub)
import Data.Maybe (fromJust)
import System.Process (CreateProcess(env))

type Nume = String
data Prop
  = Var Nume
  | F
  | T
  | Not Prop
  | Prop :|: Prop
  | Prop :&: Prop
  | Prop :->: Prop  --ex 9
  | Prop :<->: Prop --ex 9
  deriving (Eq, Read)
infixr 2 :|:
infixr 3 :&:

--Exercitiul 1
--ex 1

p1 :: Prop
p1 = (Var "P" :|: Var "Q") :&: (Var "P" :&: Var "Q")

--ex 2

p2 :: Prop
p2 = (Var "P" :|: Var "Q") :&: (Not (Var "P") :&: Not (Var "Q"))

--ex 3

p3 :: Prop
p3 = (Var "P" :&: (Var "Q" :|: Var "R")) :&: ((Not (Var "P") :|: Not (Var "Q")) :&: (Not (Var "P") :&: Not (Var "R")))


--Exercitiul 2
 
test_ShowProp :: Bool
test_ShowProp =
    show (Not (Var "P") :&: Var "Q") == "((~P)&Q)"

instance Show Prop where
  show (Var n) = n
  show F = "False"
  show T = "True"
  show (Not prop) = "(~" ++ show prop ++ ")"
  show (prop1 :|: prop2) = "(" ++ show prop1 ++ "|" ++ show prop2 ++ ")"
  show (prop1 :&: prop2) = "(" ++ show prop1 ++ "&" ++ show prop2 ++ ")"


--Exercitiul 3

type Env = [(Nume, Bool)]

impureLookup :: Eq a => a -> [(a,b)] -> b
impureLookup a = fromJust . lookup a

eval :: Prop -> Env -> Bool
eval (Var x) env = impureLookup x env 
eval T _ = True
eval (x :&: y) env = eval x env && eval y env
eval (x :|: y) env = eval x env || eval y env
eval (p1 :->: p2) env = eval p1 env `impl` eval p2 env --ex 9
eval (p1 :<->: p2) env = eval p1 env `echi` eval p2 env --ex 9
eval (Not t) env = not (eval t env)
eval F _ = False


--Exercitiul 4

variabile :: Prop -> [Nume]
variabile (Var p) = [p]
variabile (Not p) = nub (variabile p)
variabile (p:|:q) = nub (variabile p ++ variabile q)
variabile (p:&:q) = nub (variabile p ++ variabile q)
variabile _ = [] -- T si False


--Exercitiul 5

envs :: [Nume] -> [Env]
envs [] = [[]]
envs (x:xs) = [env ++ [(x,v)] | env <- envs xs,
                v <- [False, True]]


--alta variatna
--envs (str:xs) = let r = envs xs in map (\x -> (str, False):x)r ++ map (\x -> (str, False):x)r


--Exercitiul 6

satisfiabila :: Prop -> Bool
satisfiabila (Var p) = True 
satisfiabila prop = or[eval prop env | env <- envs (variabile prop)]


--Exercitiul 7

valida :: Prop -> Bool
valida p = not(satisfiabila (Not p))


--Exercitiul 9

impl :: Bool -> Bool -> Bool
impl False _ = True
impl _ x = x

echi :: Bool -> Bool -> Bool
echi p1 p2 = p1 == p2


--Exercitiul 10

echivalenta :: Prop -> Prop -> Bool
echivalenta p1 p2 = and[eval p1 env == eval p2 env | env <- envs (variabile (p1 :|: p2))]