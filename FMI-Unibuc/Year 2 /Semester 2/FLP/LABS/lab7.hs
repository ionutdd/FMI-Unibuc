data LambdaTerm = Var String | Lam String LambdaTerm | App LambdaTerm LambdaTerm
    deriving Show

-- union of two sets represented as lists
union2 :: (Eq a) => [a] -> [a] -> [a]
union2 x y = x ++ [z | z <- y, notElem z x]

-- variables of a lambda term
var :: LambdaTerm -> [String]
var (Var x) = [x]
var (Lam x t) =  [x] `union2` (var t)
var (App t1 t2) = var t1 `union2` var t2

-- free variables of a lambda term
fv :: LambdaTerm -> [String]
fv (Var x) = [x]
fv (Lam x t) = filter (/= x) (fv t)
fv (App t1 t2) = fv t1 `union2` fv t2

-- an endless reservoir of variables
freshvarlist :: [String]
freshvarlist = map ("x" ++) (map show [0..])

-- fresh variable for a term
freshforterm :: LambdaTerm -> String
freshforterm t = head $ filter (`notElem` var t) freshvarlist

-- the substitution operation for lambda terms
subst :: LambdaTerm -> String -> LambdaTerm -> LambdaTerm
subst (Var y) x s = if y == x then s else Var y
subst (Lam y t) x s
    | y == x = Lam y t
    | y `notElem` fv s = Lam y (subst t x s)
    | otherwise = Lam z (subst (subst t y (Var z)) x s)
    where z = freshforterm t
subst (App t1 t2) x s = App (subst t1 x s) (subst t2 x s)


test_subst = subst (Lam "x" (App (Var "y") (Var "x"))) "y" (Var "x")

-- beta reduction in one step
beta1 :: LambdaTerm -> [LambdaTerm]
beta1 (Var x) = []
beta1 (Lam x y) = map (Lam x) (beta1 y)
beta1 (App (Lam x t) s) = [subst t x s] ++ [App (Lam x t') s | t' <- beta1 t] ++ [App (Lam x t) s' | s' <- beta1 s]


-- checks whether a term is in normal form
nf :: LambdaTerm -> Bool
nf = undefined

data TermTree = TermTree LambdaTerm [TermTree]
    deriving Show

-- the beta-reduction tree of a lambda term
reductree :: LambdaTerm -> TermTree
reductree t = undefined

-- depth-first traversal of all the nodes in a term tree
df_all :: TermTree -> [LambdaTerm]
df_all (TermTree t l) = undefined

-- just the leaves
df_leaves :: TermTree -> [LambdaTerm]
df_leaves = undefined

-- the left-most outer-most reduction of a term
reduce :: LambdaTerm -> LambdaTerm
reduce = undefined

term1 = App (App (Lam "x" (Lam "y" (App (Var "x") (Var "y")))) (Var "z")) (Var "w")
term2 = App (Lam "x" (App (Lam "y" (Var "x")) (Var "z"))) (Var "w")

test_beta1 = df_leaves (reductree term1)
test_beta2 = df_leaves (reductree term2)

-- a branch of given length in a tree
branch :: Int -> TermTree -> Maybe [LambdaTerm]
branch = undefined
                                
testbranch1 = branch 2 (reductree term1)
                                
testbranch2 = branch 3 (reductree term1)

term_o = Lam "x" (App (Var "x") (Var "x"))
term_O = App term_o term_o

testO = reduce term_O -- should not terminate

term_b = App (App (Lam "x" (Lam "y" (Var "y"))) term_O) (Var "z")

testb = reduce term_b -- should terminate
                                
testbranch3 = branch 10 (reductree term_b)

-- Church numeral of a number
church :: Int -> LambdaTerm
church n = undefined

-- convert from Church numeral back to number
backch :: LambdaTerm -> Int
backch = undefined

-- lambda term for successor
tsucc :: LambdaTerm 
tsucc = undefined

testsucc = backch ((reduce (App tsucc (church 7))))

-- lambda term for addition
tadd :: LambdaTerm
tadd = undefined

testadd = backch ((reduce (App (App tadd (church 7)) (church 8))))