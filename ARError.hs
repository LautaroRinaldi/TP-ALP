module ARError where
import Control.Monad
import Control.Applicative

newtype ARError a = ARError { run :: Either String a } deriving (Show, Eq)

instance Monad ARError where
  return x = ARError (Right x)
  m >>= f  = case (run m) of
                   Left  x -> throw x
                   Right y -> f y
instance Functor ARError where
   fmap       = liftM
 
instance Applicative ARError where
    pure       = return
    (<*>)      = ap      

class Monad m => MonadError m where
    throw :: String->m a

instance MonadError ARError where
    throw s = ARError (Left s)

instance Alternative ARError where
    empty = throw "error"
    x <|> y = case run x of
                   Left  a -> y
                   Right b -> return b

