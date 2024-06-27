import Data.Char

newtype Parser a = Parser { parse :: String -> [(a,String)] }

item :: Parser Char
item = Parser (\cs -> case cs of
                "" -> []
                (c:cs) -> [(c,cs)])


-- >>= se numeste bind si trebuie practic definita 

instance Monad Parser where
    return a = Parser (\cs -> [(a,cs)])
    --(>>=) :: Parser a -> (a -> Parser b) -> Parser b
    p >>= f = Parser (\cs -> concat (map (\(a, cs') -> (parse (f a) cs')) (parse p cs)))

instance Applicative Parser where
    pure = return

    -- op. ap e ce e mai jos 
    --(<*>) :: Parser (a -> b) -> Parser a -> Parser b
    mf <*> ma = do
        f <- mf
        va <- ma
        return (f va)    

instance Functor Parser where              
    fmap f ma = pure f <*> ma   
  
{-
instance Functor Parser where              
    fmap g p = Parser (\cs -> map (\(a,cs') -> (g a, cs')) (parse p cs))

instance Applicative Parser where
    pure a = Parser (\cs -> [(a, cs)])
    pg <*> pa = Parser (\cs -> concat (map (\(g, cs') -> (parse (fmap g pa) cs')) (parse pg cs)))

instance Monad Parser where
    p >>= f = Parser (\cs -> concat (map (\(a, cs') -> (parse (f a) cs')) (parse p cs)))
-}

zero :: Parser a
zero = Parser (const [])

psum :: Parser a -> Parser a -> Parser a
psum p q = Parser (\cs -> (parse p cs) ++ (parse q cs))

(<|>) :: Parser a -> Parser a -> Parser a
p <|> q = Parser (\cs -> case parse (psum p q) cs of
                                [] -> []
                                (x:xs) -> [x])

dpsum0 :: Parser [a] -> Parser [a]
dpsum0 p = p <|> (return [])

sat :: (Char -> Bool) -> Parser Char
sat p = do
            c <- item
            if p c then return c else zero

char :: Char -> Parser Char
char c = sat (c ==)

string :: String -> Parser String
string [] = return []
string (c:cs) = do
                    pc <- char c
                    prest <- string cs
                    return (pc : prest)

many0 :: Parser a -> Parser [a]
many0 p = dpsum0 (many1 p)

many1 :: Parser a -> Parser [a]
many1 p = do 
    a <- p
    aa <- many0 p
    return (a : aa)

spaces :: Parser String
spaces = many0 (sat isSpace)

token :: Parser a -> Parser a
token p = do
            spaces
            x <- p
            spaces
            return x

symbol :: String -> Parser String
symbol symb = token (string symb)

sepBy0 :: Parser a1 -> Parser a2 -> Parser [a1]
p `sepBy0` sep = dpsum0 (p `sepBy1` sep)

sepBy1 :: Parser a1 -> Parser a2 -> Parser [a1]
p `sepBy1` sep = do
                    a <- p
                    as <- many0 (do
                                    sep
                                    p)
                    return (a:as)

look :: Parser (Maybe Char)
look = Parser (\cs -> case cs of
      [] -> [(Nothing, [])]
      (c:cs') -> [(Just c, c:cs')]
    )

takeUntil :: Char -> Parser [Char]
takeUntil stop = consumeRest "" stop
    where consumeRest acc stop = do
                                    l <- look
                                    if l == Just stop then return [] else do
                                                                            c <- item
                                                                            cs <- consumeRest (acc ++ [c]) stop
                                                                            return (c:cs)

chainl1 :: Parser t -> Parser (t -> t -> t) -> Parser t
p `chainl1` op = do
                    x <- p
                    rest x
                 where rest x = (do
                                    f <- op
                                    y <- p
                                    rest (f x y)
                                ) <|> return x

digit :: Parser Int
digit = do
            d <- sat isDigit
            return (digitToInt d)

integer :: Parser Int
integer = do
              spaces
              d <- digitToInt <$> sat isDigit
              if d == 0 
                then 
                  return 0 
                else 
                  do
                    ds <- many0 digit
                    return (asInt (d:ds))
          where asInt ds = sum [d * (10^p) | (d, p) <- zip (reverse ds) [0..] ]

number :: Parser Double
number = withDecimalPt <|> withoutDecimalPt
  where
    withoutDecimalPt = fromIntegral <$> integer
    withDecimalPt = do
                      wholePart <- withoutDecimalPt
                      char '.'
                      fractionalPart <- fmap asFracPt (many0 digit)
                      return (wholePart + fractionalPart)
    asFracPt ds = sum [fromIntegral d * (10 ** (-p)) | (d, p) <- zip ds [1..]]

addop :: Parser (Exp -> Exp -> Exp)
addop = add <|> sub
  where add = do
                symbol "+"
                return (Add)
        sub = do
                symbol "-"
                return (Sub)

mulop :: Parser (Exp -> Exp -> Exp)
mulop = mul <|> div
  where mul = do
                symbol "*"
                return (Mul)
        div = do
                symbol "/"
                return (Div)

factor :: Parser Exp
factor = negativeFactor <|> parensExpr <|> fmap Num number
  where
    negativeFactor = do
                        symbol "-"
                        Min <$> factor
    parensExpr = do
                    symbol "("
                    x <- expr
                    symbol ")"
                    return x
                    
term :: Parser Exp
term = factor `chainl1` mulop

expr :: Parser Exp
expr = term `chainl1` addop

--1. Testati parser-ul de mai sus

--parse expr "1+2-3/(4*5)"

--2. Creati un tip de date abstract (inductiv) pt expresii aritmetice si modificati parser-ul astfel incat el sa returneze o asemenea expresie

data Exp = Num Double | Add Exp Exp | Mul Exp Exp | Div Exp Exp | Sub Exp Exp | Min Exp
    deriving Show

-- + s-au facut niste modificari la addop, mulop si factor

--fmap Num number

--Practic trebuie sa facem asta: (modifcam de la 159 in jos)

--data Exp = Num Exp | Add Exp Exp | ...

--1 + 2 -> 3
--returneaza asta: Add (Number 1) (Number 2))