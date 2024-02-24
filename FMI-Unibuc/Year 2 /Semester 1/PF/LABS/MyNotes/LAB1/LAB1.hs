import Data.List

myInt = 31415926535897932384626433832795028841971693993751058209749445923
double :: Integer -> Integer
double x = x+x

maxim :: Integer -> Integer -> Integer
maxim x y = if (x > y) then x else y

--maxim3 x y z = let u = (maxim x y) in (maxim u z)      varianta cu let
--maxim 3 x y z = maxim x (maxim y z) --varianta doar cu max
maxim3 x y z = if (x >= y) then if (z >= x) then z else x else if (z >= y) then z else y --Maxim3 cu if-uri 
    
--varianta cu identare
{-
maxim3 x y z =
    let
        u = maxim x y
    in
        maxim u z
-}

--maxim4 scrisa de mine cu "let"-uri
maxim4 :: Integer -> Integer -> Integer -> Integer -> Integer
maxim4 x y z t = 
    let 
        k = maxim x y
    in 
        let 
            u = maxim k z
        in 
            maxim u t 
    
--functia de verificare a lui maxim4 scrisa de mine
verif :: Integer -> Integer -> Integer -> Integer -> Bool
verif x y z t =
    if((maxim4 x y z t) >= x && (maxim4 x y z t) >= y && (maxim4 x y z t) >= z && (maxim4 x y z t) >= t)
        then True
        else False



--8a functie cu 2 param care calculeaza suma patratelor

sumaPat :: Integer -> Integer -> Integer
sumaPat x y = x * x + y * y


--8b o functie cu un parametru ce întoarce stringul “par” dacă parametrul este par si “impar” altfel

paritate :: Integer -> String
paritate x = if (mod x 2 == 1) then "impar" else "par"
--paritate x = if (x `mod` 2 == 1) then "impar" else "par"   asta e cu mod intre


--8c o functie care calculează factorialul unui număr

factorial :: Integer -> Integer
factorial 0 = 1
factorial x = x * factorial (x-1)


--8d o functtie care verifică dacă primul parametru este mai mare decât dublul celui de-al doilea parametru

gigantic :: Integer -> Integer -> String
gigantic x y = if (x > y * 2) then "x e mai mare decat dublul lui y" else "x nu e mai mare decat dublul lui y"


--8e o functie care calculează elementul maxim al unei liste

maximLista :: [Integer] -> Integer
maximLista [] = -1
maximLista (p : ps) = maxim p (maximLista ps)