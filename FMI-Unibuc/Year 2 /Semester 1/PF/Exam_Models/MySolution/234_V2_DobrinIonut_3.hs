newtype AE a = AE {getAE :: (Either String a, String)} deriving Show

instance Monad AE where
    return x = AE (Right x, "")

    (AE (Left err, log1)) >>= f = AE (Left err, log1)
    (AE (Right x, log1)) >>= f =
        let (AE (result, log2)) = f x
        in AE (result, log1 ++ log2)
