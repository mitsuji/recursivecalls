-- stack runhaskell FRec.hs
-- stack ghc -- FRec.hs

import Data.Int



main :: IO()
main = frec 0


frec :: Int -> IO()
frec x = do
  putStrLn $ show x
  frec $ x+1

