-- stack runhaskell Series2S.hs
-- stack ghc -- Series2S.hs
-- stack ghc -- -O2 Series2S.hs

import Data.Int (Int64)


main :: IO()
main =
  putStrLn $ show $ series 10 0
--  putStrLn $ show $ series 100000000 0 -- 時間化かかるけどOK


series :: Int64 -> Int64 -> Int64
series x acc =
  if x == 0
    then acc
    else series (x-1) $! acc+x
