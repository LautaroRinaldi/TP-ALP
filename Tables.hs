module Tables where
import ASTTablas
import Data.List
import Data.Char (toLower)
import ARError
------------------------------------------------------------------------------------------
palabrasReservadas::[String]
palabrasReservadas=["ans", "all", "seleccionar", "proyectar", "renombrar", "renombrarcol", "unir", "intersecar", "restar", "dividir", "natural", "carteciano", "and", "or", "not"]

checkNameT :: String -> ARError () 
checkNameT t = if elem (mini t) palabrasReservadas 
               then throw (t++" es una palabra reservada.") 
               else return ()

checkNameC :: [String] -> ARError ()
checkNameC []     = return ()
checkNameC (c:cs) = do checkNameT c
                       checkNameC cs


mini:: String -> String
mini = map toLower

---------------------------------------------------------------------------------------------
transform:: Archivo -> ARError DB
transform []     = return []
transform (a:as) = do x  <- tablaToNamedTable a
                      xs <- transform as
		      checkArch (x:xs)
                      return (x:xs)

newNamedTable  ::String -> Table -> ARError NamedTable
newNamedTable  name cont = do checkTab (Tab name c)
                              return   (Tab name c)
			   where c= (map (\((a1,a2),a3)->((name,a2),a3)) cont)

tablaToNamedTable:: Tabla -> ARError NamedTable
tablaToNamedTable (T name enc cont) = do checkNameT name
					 checkNameC $map fst enc
					 c <- cont
					 newNamedTable name (newEncComplete c)
                                       where
                                            col              = (map fst enc)
                                            newEncEmpty      = map (\(s,t)->((name, s),if t==TChar then (Left []) else (Right []))) enc
                                            newEnc []     es = es
                                            newEnc (c:cs) es = newEnc cs (addLine c es)
                                            newEncComplete x = newEnc (reverse x) newEncEmpty


addLine:: Linea -> Table -> Table
addLine l e = case (l             , e              ) of
                   ([]            , []             )-> []
                   (((Left  a):as), (s,Left  ls):es)-> (s,Left  (a:ls)):(addLine as es)
                   (((Right a):as), (s,Right ls):es)-> (s,Right (a:ls)):(addLine as es)
                   ( _            , _              )-> error "No deberia llegar aca, función addLine.\n Error de tipos."

checkArch :: DB -> ARError ()
checkArch a = do checkNameNamedTable a
                 checkTabs a

checkNameNamedTable:: DB -> ARError ()
checkNameNamedTable file = if dif==[] then return () else throw ("Hay mas de una tabla con el\\los nombre\\s: "++(init(tail (show dif))))
                      where namesNamedTable       = extracNameNamedTable file
                            namesNamedTableUnique = nub namesNamedTable
                            dif                   = namesNamedTable\\namesNamedTableUnique

extracNameNamedTable :: DB -> [String]
extracNameNamedTable file = map nameNamedTable file

checkTabs :: [NamedTable] -> ARError ()
checkTabs []     = return ()
checkTabs (x:xs) = do checkTab  x
                      checkTabs xs 

checkTab :: NamedTable -> ARError ()
checkTab t = do checkNameColumn t
		checkColumnLong t

checkNameColumn::NamedTable -> ARError ()
checkNameColumn (Tab n c) = if dif then return () else throw ("Hay mas de una colmuna con el\\los nombre\\s: "++(init(tail (show dif)))++" en la tabla "++n++".a comido")
                        where namesColumn       = extractName c
                              namesColumnUnique = nub namesColumn
                              dif               = (length namesColumn)==(length namesColumnUnique)

extractName:: Table-> [ColumnNameT]
extractName cs = (map (\(a,b)->a) cs)
extractCont:: Table-> [Either [String] [Int]]
extractCont cs = (map (\(a,b)->b) cs)

nameNamedTable::NamedTable -> String
nameNamedTable (Tab n _) = n
contNamedTable::NamedTable -> Table
contNamedTable (Tab _ c) = c

--CREO que no debería llegar aca
checkColumnLong:: NamedTable -> ARError ()
checkColumnLong (Tab n c) = if cond then return () else throw ("Alguna fila de la tabla "++n++" no tiene argumentos suficientes.")
			    where cond    = (((filter (\x->(ncont!!0)/=x) ncont))==[])
                                  ncont   = map (\s->trans s) cont
                                  cont    = (map (\(cn,cc)-> either Left Right cc) c )
                                  trans::Either [a] [b]->Int
                                  trans s = case s of
                                              (Left  cs) -> length cs
                                              (Right cs) -> length cs


