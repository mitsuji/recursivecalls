-- stack runhaskell Series1.hs
-- stack ghc -- Series1.hs
-- stack ghc -- -O2 Series1.hs

import Data.Int (Int64)


main :: IO()
main =
  putStrLn $ show $ series 100
--  putStrLn $ show $ series 100000000 -- stack overflow



series :: Int64 -> Int64
series x =
  if x == 0
    then 0
    else x + series (x-1)

