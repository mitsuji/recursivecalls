-- stack runhaskell Series2L.hs
-- stack ghc -- Series2L.hs
-- stack ghc -- -O2 Series2L.hs

import Data.Int (Int64)


main :: IO()
main =
  putStrLn $ show $ series 10 0
--  putStrLn $ show $ series 100000000 0 -- 強制終了


series :: Int64 -> Int64 -> Int64
series x acc =
  if x == 0
    then acc
    else series (x-1) $ acc+x
