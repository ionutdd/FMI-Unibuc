{-# OPTIONS_GHC -Wno-overlapping-patterns #-}
data List a = Nil
        | Cons a (List a)
    deriving (Eq, Show)


--Ex 1
instance Functor List where
    fmap f (Cons a b) = Cons (f a) (fmap f b)
    fmap f Nil = Nil

instance Applicative List where
    pure a = Cons a Nil --creeaza acest tip de date cu un singur element 
    Nil <*> list = Nil
    Cons f list <*> list2 = lappend (fmap f list2) (list <*> list2)
                        where
                            lappend Nil list = list
                            lappend (Cons a list) list2 = Cons a (lappend list list2)

--2 a)
data Cow = Cow {
        name :: String
        , age :: Int
        , weight :: Int
        } deriving (Eq, Show)


noEmpty :: String -> Maybe String
noEmpty str = if null str then Nothing else Just str

noNegative :: Int -> Maybe Int
noNegative integer = if integer < 0 then Nothing else Just integer


--b)

cowFromString :: String -> Int -> Int -> Maybe Cow
cowFromString n a w = do  --asta returneaza Maybe
                        new_n <- noEmpty n
                        new_a <- noNegative a
                        new_w <- noNegative w
                        return (Cow new_n new_a new_w)
                    --sau Cow (noEmpty n) (noNegative a) (noNegative w)

--c)
cowFromString n a w = Cow <$> noEmpty n <*> noNegative a <*> noNegative w
                    --fmap Cow (no...) <*> fmap (...) ...

--3

--diferente:
    -- type -> tip     type Nume = String
    --newtype -> un nou tip definit de noi          newtype Nume = Nume String
    --data -> fie poate sa aiba mai multi constructori fie mai multi parametri    data Nume = Nume String String
                                                                                            -- |Nil
 

newtype Name = Name String deriving (Eq, Show)
newtype Address = Address String deriving (Eq, Show)

data Person = Person Name Address
    deriving (Eq, Show)

--3a)

validateLength :: Int -> String -> Maybe String
validateLength integer str = if length str < integer then Just str else Nothing

--3b)

mkAdress :: String -> Maybe Address
mkAdress a = case validateLength 100 a of 
                  Nothing -> Nothing 
                  Just a -> Just (Address a)

mkName :: String -> Maybe Name
mkName a = case validateLength 25 a of 
                  Nothing -> Nothing 
                  Just a -> Just (Name a)

--3c)
mkPerson :: String -> String -> Maybe Person
mkPerson n a = case mkName n of
                    Nothing -> Nothing
                    Just n -> case mkAdress a of
                                   Nothing -> Nothing
                                   Just a -> Just (Person n a)
                
--3d)
mkName2 n = Name <$> validateLength 25 n
mkAddress2 a = Address <$> validateLength 100 a
mkPerson2 n a = Person <$> mkName2 n <*> mkAddress2 a