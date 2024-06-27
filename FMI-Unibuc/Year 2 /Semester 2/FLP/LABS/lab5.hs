data Term = Variable String | FuncSym String [Term]
    deriving (Eq, Show)

-- returns all variables of a term
var :: Term -> [String]
var (Variable x) = [x]  
var (FuncSym _ subterms) = concatMap var subterms  

-- substitutes, in a term, a variable by another term
subst :: Term -> String -> Term -> Term
subst (Variable x) varName newTerm =
  if x == varName
    then newTerm
    else Variable x
subst (FuncSym name subterms) varName newTerm =
  FuncSym name (map (\t -> subst t varName newTerm) subterms)

data Equ = Equ Term Term
    deriving Show

data StepResult = FailureS | Stopped | SetS [Equ]
    deriving Show

step1 :: [Equ] -> StepResult
step1 [] = Stopped 
step1 ((Equ (FuncSym name1 subterms1) (FuncSym name2 subterms2)):eqs)
    | name1 == name2 = SetS (zipWith Equ subterms1 subterms2 ++ eqs) 
step1 (eq:eqs) = case (step1 eqs) of   
                    FailureS -> FailureS
                    Stopped -> Stopped
                    SetS newEqs -> SetS (eq : newEqs)


step2 :: [Equ] -> StepResult
step2 [] = Stopped 
step2 ((Equ (FuncSym name1 subterms1) (FuncSym name2 subterms2)):eqs)
    | name1 /= name2 = FailureS
    | length subterms1 /= length subterms2 = FailureS 
step2 (eq:eqs) = case (step2 eqs) of   
                    FailureS -> FailureS
                    Stopped -> Stopped
                    SetS newEqs -> SetS (eq : newEqs)

step3 :: [Equ] -> StepResult
step3 [] = Stopped  
step3 (eq:eqs) =
    case eq of
        Equ (Variable x) (Variable y)
            | x == y -> step3 eqs  
        _ -> case step3 eqs of
                FailureS -> FailureS  
                Stopped -> Stopped    
                SetS newEqs -> SetS (eq : newEqs)


step4 :: [Equ] -> StepResult
step4 [] = Stopped  
step4 ((Equ t (Variable x)):eqs)
    | isVariable x && not (isVariableInTerm x t) = SetS (Equ (Variable x) t : eqs) 
  where
    isVariable :: String -> Bool
    isVariable ('x':xs) = all (`elem` ['0'..'9']) xs  
    isVariable _ = False

    isVariableInTerm :: String -> Term -> Bool
    isVariableInTerm var (Variable y) = var == y
    isVariableInTerm var (FuncSym _ subterms) = any (isVariableInTerm var) subterms
step4 (eq:eqs) = case (step4 eqs) of   
                    FailureS -> FailureS
                    Stopped -> Stopped
                    SetS newEqs -> SetS (eq : newEqs)   



step5 :: [Equ] -> StepResult
step5 [] = Stopped  
step5 ((Equ (Variable x) t):eqs)
    | containsVariable x t && t == Variable x = FailureS  
  where
    containsVariable :: String -> Term -> Bool
    containsVariable var (Variable y) = var == y
    containsVariable var (FuncSym _ subterms) = any (containsVariable var) subterms
step5 (eq:eqs) = case (step5 eqs) of   
                    FailureS -> FailureS
                    Stopped -> Stopped
                    SetS newEqs -> SetS (eq : newEqs)   

-- candidates for "x=t" in step 6 of the algorithm
step6cand :: [Equ] -> [Equ]
step6cand = filter isCandidate
  where
    isCandidate :: Equ -> Bool
    isCandidate (Equ (Variable x) t) =
      case t of
        Variable y -> x == y && notElem x (var t)
        _ -> False
    isCandidate _ = False

-- substitutes in a list of equations a variable by a term EXCEPT for the equation "variable=term" (as used in step 6 of the algorithm)
substeq :: [Equ] -> String -> Term -> [Equ]
substeq [] _ _ = []  
substeq ((Equ (Variable x) t):eqs) varName newTerm
    | Variable x == t = Equ (Variable x) t : substeq eqs varName newTerm  
    | otherwise = Equ (Variable x) (subst t varName newTerm) : substeq eqs varName newTerm 
substeq (eq:eqs) varName newTerm = eq : substeq eqs varName newTerm  


step6 :: [Equ] -> StepResult
step6 eqs =
    case step6cand eqs of
        [] -> SetS eqs  
        candidates -> SetS (applySubstitution eqs candidates)
    where
    applySubstitution :: [Equ] -> [Equ] -> [Equ]
    applySubstitution eqsToSubst candidates =
        foldl (\acc eq -> substeq acc (getVarName eq) (getTerm eq)) eqsToSubst candidates
      where
        getVarName :: Equ -> String
        getVarName (Equ (Variable x) _) = x
        getVarName _ = error "Not a candidate equation for step 6"

        getTerm :: Equ -> Term
        getTerm (Equ _ t) = t
  

                
onestep :: [Equ] -> StepResult
onestep es = case (step1 es) of
              SetS fs -> SetS fs
              Stopped -> case (step2 es) of
                          FailureS -> FailureS
                          Stopped -> case (step3 es) of
                                      SetS fs -> SetS fs
                                      Stopped -> case (step4 es) of
                                                  SetS fs -> SetS fs
                                                  Stopped -> case (step5 es) of
                                                              FailureS -> FailureS
                                                              Stopped ->  case (step6 es) of
                                                                           SetS fs -> SetS fs
                                                                           Stopped -> Stopped

data AllResult = Failure | Set [Equ]
    deriving Show

unify :: [Equ] -> AllResult
unify es = case (onestep es) of
                    Stopped -> Set es
                    FailureS -> Failure
                    SetS fs -> unify fs
                    
eqset1 = [Equ (Variable "z") (FuncSym "f" [Variable "x"]), Equ (FuncSym "f" [Variable "t"]) (Variable "y")]
         -- z=f(x), f(t)=y  --> should have z=f(x), y=f(t)

eqset2 = [Equ (FuncSym "f" [Variable "x", FuncSym "g" [Variable "y"]]) (FuncSym "f" [FuncSym "g" [Variable "z"], Variable "z"])]
         -- f(x,g(y))=f(g(z),z) --> should have x=g(g(y)), z=g(y)

eqset3 = [Equ (FuncSym "f" [Variable "x", FuncSym "g" [Variable "x"], FuncSym "b" []]) (FuncSym "f" [FuncSym "a" [], FuncSym "g" [Variable "z"], Variable "z"])]
          -- f(x,g(x),b)=f(a,g(z),z) --> should return failure