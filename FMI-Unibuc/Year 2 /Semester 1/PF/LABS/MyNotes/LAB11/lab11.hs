newtype Identity a = Identity a

data Pair a = Pair a a

data Constant a b = Constant b

data Two a b = Two a b

data Three a b c = Three a b c

data Three' a b = Three' a b b

data Four a b c d = Four a b c d

data Four'' a b = Four'' a a a b

data Quant a b = Finance | Desk a | Bloor b


data LiftItOut f a = LiftItOut (f a)

data Parappa f g a = DaWrappa (f a) (g a)

data IgnoreOne f g a b = IgnoringSomething (f a) (g b)

data Notorious g o a t = Notorious (g o) (g a) (g t)

data GoatLord a = NoGoat | OneGoat a | MoreGoats (GoatLord a) (GoatLord a) (GoatLord a)

data TalkToMe a = Halt | Print String a | Read (String -> a)






--functori

--sunt o clasa care contine o singura o functie si un fmap
--map aplica po fct pe o lista si aplica aceeasi fct pe toata lista
--fmap :: (a -> b) -> f a -> f b



--list2 = [1, 2, 3]
--fmap (*2) list 2 --> 2, 4, 6


--maybe1 = Just 3
--fmap (*2) maybe 1 --> Just 6


--Ex:
data Mes a = Mes    
    {totalsize :: a,
    nB :: Int,
    nBs :: a,
    eRs :: a
    }deriving (Show, Eq)
--pentru ca nb e de tip int si nu e de tip a, el va fi lasat neschimbat de fct fmap

instance Functor Mes where
    fmap g (Mes ts nb nbs ers) = Mes (g ts) nb (g nbs) (g ers) -- asta e doar ca sa intelegem ce face defapt fmap


--Exercitii
instance Functor Identity where
    fmap g (Identity a) = Identity (g a)

instance Functor Pair where
    fmap g (Pair a a1) = Pair (g a) (g a1)

instance Functor (Constant a) where
    fmap g (Constant b) = Constant (g b)

instance Functor (Two a) where
    fmap g (Two a b) = Two a (g b)

instance Functor (Three a b) where
    fmap g (Three a b c) = Three a b (g c) 

instance Functor (Three' a) where
    fmap g (Three' a b1 b2) = Three' a (g b1) (g b2)

instance Functor (Four a b c) where
    fmap g (Four a b c d) = Four a b c (g d)

instance Functor (Four'' a) where
    fmap g (Four'' a1 a2 a3 b) = Four'' a1 a2 a3 (g b)

instance Functor (Quant a) where
    fmap g (Finance) = Finance
    fmap g (Desk a) = Desk a
    fmap g (Bloor b) = Bloor (g b)

instance Functor f => Functor (LiftItOut f) where
    fmap g (LiftItOut fa) = LiftItOut (fmap g fa) --fa = val de tip f a

    

instance (Functor f, Functor g) => Functor (Parappa f g) where
    fmap f (DaWrappa fa fb) = DaWrappa (fmap f fa) (fmap f fb)

instance (Functor g) => Functor (IgnoreOne f g a) where 
    fmap func (IgnoringSomething fa gb) = IgnoringSomething fa (fmap func gb)

instance (Functor g) => Functor (Notorious g o a) where
    fmap func (Notorious go ga gt) = Notorious go ga (fmap func gt)

instance Functor GoatLord where
    fmap g (NoGoat) = NoGoat
    fmap g (OneGoat a) = OneGoat (g a)
    fmap g (MoreGoats g1 g2 g3) = MoreGoats (fmap g g1) (fmap g g2) (fmap g g3)

instance Functor TalkToMe where
    fmap g (Halt) = Halt
    fmap g (Print str a) = Print str (g a)
    fmap g (Read fa) = Read (g.fa) --fa :: String -> a