module PrettyPrinter where
import AST
import ASTTablas
import Tables
import Operaciones
import Data.Char
import Data.List


printNameDB:: DB -> IO ()
printNameDB []     = return ()
printNameDB (t:ts) = do printNameTable t
                        printNameDB    ts

printNameTable::NamedTable -> IO ()
printNameTable t = putStrLn $ nameNamedTable t

printBD = printDB

printDB:: DB -> IO ()
printDB []     = return ()
printDB (t:ts) = do printNamedTable t
                    printDB ts

printNamedTable:: NamedTable -> IO ()
printNamedTable t = do printNameTable t
                       printTable $ contNamedTable t

printColumns::Table -> IO ()
printColumns t = do mapM_ (\x->do putStr (show x)
			          putStr "   "  ) (extractName t)
                    putStr "\n"

printTable::Table -> IO ()
printTable t = do mapM_ (\x->putStr (compi (maxi!!x) (Left (ns!!x)))) [0..n] 
                  case long cs>=0 of
                        True  -> mapM_ (\i->(mapM_ (\x->if x==0
                                         then putStr ("\n"++(compi (maxi!!x) ((rs!!i)!!x))  )
                                         else putStr ((compi (maxi!!x) ((rs!!i)!!x))  )) [0..n])    ) [0..long cs]
                        False -> putStr "\n\nTabla vacia"
                                    
		  putStr "\n"
               where maxi = map (\i-> (max (mns!!i) (mcs!!i))+3) [0..n]
                     n    = ((length ns)-1)
                     mns  = (map length ns)
                     mcs  = (map f cs)
                     ns   = map snd $ extractName t
                     cs   = extractCont t
                     rs   = columnToRow cs
                     f (Left  xs) = foldl max 0 (map length xs)
                     f (Right xs) = foldl max 0 (map (\x-> (length (show x))) xs)
                     compi::Int -> Either String Int -> String
                     compi i (Left  xs) = xs++(replicate (i-(length xs)) ' ')
                     compi i (Right xs) = (show xs)++(replicate (i-(length (show xs))) ' ')
                     long con = case con of
                                     ((Left  cs):css) -> (length cs) -1
                                     ((Right cs):css) -> (length cs) -1
                                     _                -> 0

