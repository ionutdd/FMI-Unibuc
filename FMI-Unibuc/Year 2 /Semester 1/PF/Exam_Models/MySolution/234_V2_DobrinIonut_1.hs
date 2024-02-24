import Data.Char

--a) fara monada

--merge perfect (zic eu)

chrr :: [Char] -> [Char]
chrr "" = ""
chrr (x:xs)
  | isLower x = '*' : chrr xs
  | isDigit x = x : x : chrr xs
  | x == 'A' = chrr xs
  | x == 'D' = chrr xs
  | x == 'T' = chrr xs
  | otherwise = x : chrr xs

--b) cu monada

chrrr :: [Char] -> [Char]
chrrr "" = ""
chrrr (x:xs) = do
  rest <- chrrr xs
  if isLower x then return ('*' : rest)
    else if isDigit x then return (x : x : rest)
    else if x == 'A' then return (rest)
    else if x == 'D' then return (rest)
    else if x == 'T' then return (rest)
    else return (x : rest)






