--1
newtype Identity a = Identity a
instance Functor Identity where
  fmap f (Identity a) = Identity (f a)

--2
data Pair a = Pair a a deriving Show

instance Functor Pair where
  fmap f (Pair a1 a2) = Pair (f a1) (f a2)

--3
data Constant a b = Constant b

-- scrieți o instanță a clasei Functor penru tipul Constant de mai sus
instance Functor (Constant a) where --Constant a = container cu un singur parametru de tip b
  fmap f (Constant b) = Constant (f b)

--4
data Two a b = Two a b

-- scrieți o instanță a clasei Functor pentru tipul Two de mai sus
instance Functor (Two a) where -- a e fixat, b e componenta pe care o mapam
  fmap f (Two a b) = Two a (f b)

--5
data Three a b c = Three a b c

-- scrieți o instanță a clasei Functor pentru tipul Three de mai sus
instance Functor (Three a b) where --a,b fixate, c componenta care trebuie mapata
  fmap f (Three a b c) = Three a b (f c)

--6
data Three' a b = Three' a b b

-- scrieți o instanță a clasei Functor pentru tipul Three' de mai sus
instance Functor (Three' a) where --a fixat, b1 si b2 trb mapate
  fmap f (Three' a b1 b2) = Three' a (f b1) (f b2)

--7
data Four a b c d = Four a b c d

instance Functor (Four a b c) where
  fmap f (Four a b c d) = Four a b c (f d)

--8
data Four'' a b = Four'' a a a b

instance Functor (Four'' a) where
  fmap f (Four'' a1 a2 a3 b) = Four'' a1 a2 a3 (f b)

--9
data Quant a b = Finance | Desk a | Bloor b

instance Functor (Quant a) where
  fmap _ Finance = Finance
  fmap _ (Desk a) = Desk a
  fmap f (Bloor b) = Bloor (f b)

--10
data LiftItOut f a = LiftItOut (f a)

instance Functor f => Functor (LiftItOut f) where
  fmap g (LiftItOut fa) = LiftItOut (fmap g fa) --fa = val de tip f a

--11
data Parappa f g a = DaWrappa (f a) (g a)

instance (Functor f, Functor g) => Functor (Parappa f g) where
  fmap f (DaWrappa fa ga) = DaWrappa (fmap f fa) (fmap f ga)

--12
data IgnoreOne f g a b = IgnoringSomething (f a) (g b)

instance (Functor g) => Functor (IgnoreOne f g a) where
  fmap f (IgnoringSomething fa gb) = IgnoringSomething fa (fmap f gb)

--13
data Notorious g o a t = Notorious (g o) (g a) (g t)

instance (Functor g) => Functor (Notorious g o a) where
  fmap f (Notorious go ga gt) = Notorious go ga (fmap f gt)

--14
data GoatLord a = NoGoat | OneGoat a | MoreGoats (GoatLord a) (GoatLord a) (GoatLord a)

instance Functor GoatLord where
  fmap f = go
    where
      go NoGoat = NoGoat
      go (OneGoat a) = OneGoat (f a)
      go (MoreGoats gl1 gl2 gl3) = MoreGoats (go gl1) (go gl2) (go gl3)

--15
data TalkToMe a = Halt | Print String a | Read (String -> a)
instance Functor TalkToMe where
  fmap _ Halt = Halt
  fmap f (Print s a) = Print s (f a)
  fmap f (Read fa) = Read (f . fa) --fmap f fa
  
  --fa = functia incapsulata
