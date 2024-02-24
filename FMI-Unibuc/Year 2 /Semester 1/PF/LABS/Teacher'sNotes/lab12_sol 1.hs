-- ex 1
data List a = Nil
            | Cons a (List a)
        deriving (Eq, Show)

instance Functor List where
    fmap f Nil = Nil
    fmap f (Cons a list) = Cons (f a) (fmap f list)

-- <*> aplică fiecare funcție din prima listă la fiecare valoare din a doua listă
instance Applicative List where
    pure a = Cons a Nil  --pure ar trebui să creeze o listă care conține doar valoarea a
    Nil <*> listElem = Nil
    --prima lista cu functii, a doua cu valori
    Cons f listf <*> listElem = lappend (fmap f listElem) (listf <*> listElem) --(f <$> listElem) `lappend` (listf <*> listElem)
        where
            lappend Nil list = list
            lappend (Cons a list1) list2 = Cons a (lappend list1 list2)

f = Cons (+1) (Cons (*2) Nil)
v = Cons 1 (Cons 2 Nil)

{-
Expected result:
Prelude> let f = Cons (+1) (Cons (*2) Nil)
Prelude> let v = Cons 1 (Cons 2 Nil)
Prelude> f <*> v
Cons 2 (Cons 3 (Cons 2 (Cons 4 Nil)))
-}

-- ex 2 

data Cow = Cow {
        name :: String
        , age :: Int
        , weight :: Int
        } deriving (Eq, Show)

noEmpty :: String -> Maybe String
noEmpty "" = Nothing
noEmpty str = Just str

noNegative :: Int -> Maybe Int
noNegative n
    | n >= 0 = Just n
    | otherwise = Nothing

-- Validating to get rid of empty strings, negative numbers

cowFromString :: String -> Int -> Int -> Maybe Cow
cowFromString name' age' weight' =
    case noEmpty name' of
        Nothing -> Nothing
        Just nammy -> case noNegative age' of
                        Nothing -> Nothing
                        Just agey -> case noNegative weight' of
                                        Nothing -> Nothing
                                        Just weighty -> Just (Cow nammy agey weighty)

{-
cowFromString :: String -> Int -> Int -> Maybe Cow
cowFromString name age weight = do
  nonEmptyName <- noEmpty name
  nonNegativeAge <- noNegative age
  nonNegativeWeight <- noNegative weight
  return (Cow nonEmptyName  nonNegativeAge nonNegativeWeight)
-}

cowFromString' :: String -> Int -> Int -> Maybe Cow
cowFromString' name' age' weight' = Cow <$> noEmpty name' <*> noNegative age' <*> noNegative weight'


-- ex 3

newtype Name = Name String deriving (Eq, Show)
newtype Address = Address String deriving (Eq, Show)


data Person = Person Name Address
    deriving (Eq, Show)


validateLength :: Int -> String -> Maybe String
validateLength maxLen s = if length s > maxLen then Nothing else Just s

mkName :: String -> Maybe Name
mkName s = case validateLength 25 s of
           Nothing -> Nothing
           Just s -> Just (Name s)

mkAddress :: String -> Maybe Address
mkAddress a = case validateLength 100 a of
                Nothing -> Nothing
                Just a -> Just (Address a)

mkPerson :: String -> String -> Maybe Person 
mkPerson n a =
    case mkName n of
        Nothing -> Nothing
        Just n' -> case mkAddress a of
                    Nothing -> Nothing
                    Just a' -> Just $ Person n' a'

{-
mkPerson :: String -> String -> Maybe Person
mkPerson nameStr addressStr = do
  name <- mkName nameStr
  address <- mkAddress addressStr
  return (Person name address)
-}

mkName2 :: String -> Maybe Name
mkName2 s = Name <$> validateLength 25 s

mkAddress2 :: String -> Maybe Address
mkAddress2 a = Address <$> validateLength 100 a

{-
mkName2 :: String -> Maybe Name
mkName2 str = Name <$> validateLength 25 str

mkAddress2 :: String -> Maybe Address
mkAddress2 str = Address <$> validateLength 100 str
-}
mkPersonApp :: String -> String -> Maybe Person
mkPersonApp n a = Person <$> mkName2 n <*> mkAddress2 a

{-utilizează <$> pentru a aplica constructorul Person și <*> pentru a combina rezultatele 
funcțiilor mkName și mkAddress. Dacă ambele funcții returnează Just, 
atunci este creat un obiect Person și împachetat în Just.
Dacă oricare dintre ele returnează Nothing, întreaga funcție mkPerson va returna Nothing.
-}

