-- stack ghc -- RecCall.hs
-- stack ghc -- -O2 RecCall.hs

import Data.Int



main :: IO()
main =
--  putStrLn "Hello"
--  putStrLn $ show  $ series1 100000000
  putStrLn $ show  $ series2 100000000 0

--	frec 0


series1 :: Int64 -> Int64
series1 x =
  if x == 0
    then 0
    else x + series1 (x-1)

series2 :: Int64 -> Int64 -> Int64
series2 x acc =
  if x == 0
    then acc
    else series2 (x-1) $! acc+x
--    else series2 (x-1) $ acc+x


frec :: Int -> IO()
frec x = do
  putStrLn $ show x
  frec $ x+1