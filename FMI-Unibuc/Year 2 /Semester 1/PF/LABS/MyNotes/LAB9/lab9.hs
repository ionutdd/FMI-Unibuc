data Tree = Empty  -- arbore vid
   | Node Int Tree Tree Tree -- arbore cu valoare de tip Int in radacina si 3 fii


class ArbInfo t where
  level :: t -> Int -- intoarce inaltimea arborelui; pt un arbore vid
                      -- se considera ca are inaltimea 0
  sumval :: t -> Int -- intoarce suma valorilor din arbore
  nrFrunze :: t -> Int -- intoarce nr de frunze al arborelui


--1

instance ArbInfo Tree where 
  level Empty = 0
  level (Node a b c d) = 1 + max (max (level b)  (level c)) (level d)
  
  sumval Empty = 0
  sumval (Node a b c d) = a + sumval b + sumval c + sumval d

  nrFrunze Empty = 0
  nrFrunze (Node a b c d) = 1 + nrFrunze b + nrFrunze c + nrFrunze d


class Scalar a where
  zero :: a
  one :: a
  adds :: a -> a -> a
  mult :: a -> a -> a
  negates :: a -> a
  recips :: a -> a

--2
instance Scalar Int where
    zero = 0
    one = 1
    adds = (+)
    mult = (*)
    negates = negate
    recips a = if a == 0 then error "error" else 1 `div` a

class (Scalar a) => Vector v a where
  zerov :: v a
  onev :: v a
  addv :: v a -> v a -> v a -- adunare vector
  smult :: a -> v a -> v a  -- inmultire cu scalare
  negatev :: v a -> v a -- negare vector


--3

data Vector2D a = Vector2D a a deriving (Eq, Show)
data Vector3D a = Vector3D a a a deriving (Eq, Show)

instance Scalar a => Vector Vector2D a where
    zerov = Vector2D zero zero
    onev = Vector2D one one 
    addv (Vector2D a b) (Vector2D c d)= Vector2D (adds a  c) (adds b d)
    smult x (Vector2D a b) = Vector2D (mult x a) (mult x b)
    negatev (Vector2D a b) = Vector2D (negates a) (negates b)

instance Scalar a => Vector Vector3D a where
    zerov = Vector3D zero zero zero
    onev = Vector3D one one one
    addv (Vector3D a b y) (Vector3D c d z)= Vector3D (adds a  c) (adds b d) (adds y z)
    smult x (Vector3D a b c) = Vector3D (mult x a) (mult x b) (mult x c)
    negatev (Vector3D a b c) = Vector3D (negates a) (negates b) (negates c)

