module Operaciones where
import AST
import ASTTablas
import Tables
import ARError
import Data.Char (toLower)
import Data.List
import Control.Monad

newDB :: DB
newDB = []

add::DB->NamedTable-> ARError DB
add fl t = do checkArch fl
              checkTab  t
              checkTabInArch fl t
              return (t:fl)

checkTabInArch::DB->NamedTable-> ARError ()
checkTabInArch []     _ = return ()
checkTabInArch (f:fs) t = case (f     , t    ) of 
                               (Tab x cx, Tab n c) -> if n==x then (checkTabInArch fs t) else throw ("La tabla "++n++" ya existe.")


isEqualC:: ColumnNameT -> ColumnNameT -> Bool
isEqualC (x1,x2) (y1,y2) = (isEqual x1 y1) && (isEqual x2 y2)

isEqualCN:: ColumnNameT -> ColumnNameT -> Bool
isEqualCN (x1,x2) (y1,y2) =(isEqual x2 y2)

isEqual:: String -> String ->Bool
isEqual (x:xs) (y:ys) = toLower x == toLower y && isEqual xs ys
isEqual [] []         = True
isEqual _ _           = False

--------------------------------------------------------------------------------------------------------------
--BASICAS-----------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
select :: PredUser -> Table -> ARError Table
select (Not p    ) t = do t1 <- select p  t
                          tf <- restaT t t1
                          return tf
select (Or  p1 p2) t = do t1 <- select p1  t
                          t2 <- select p2  t
                          tf <- unionT t1 t2
                          return tf
select (And p1 p2) t = do t1 <- select p1  t
                          t2 <- select p2  t
                          tf <- intersectT t1 t2
                          return tf
select p           t = do predSys <- uToS (extractName t) p
                          modifCont predSys t

unionT:: Table -> Table ->  ARError Table
unionT t1 t2 = do precondOp t1 t2
                  modCol t1 (rowToColumn (union (r t1) (r t2)))
               where r  x = columnToRow (cc x)
                     cc x = extractCont x

restaT:: Table -> Table -> ARError Table
restaT t1 t2 = do precondOp t1 t2
                  modCol t1 (rowToColumn ((r t1) \\ (r t2)))
               where r  x = columnToRow (cc x)
                     cc x = extractCont x

cartesiano :: Table -> Table -> ARError Table
cartesiano t1 t2= do checkNameColumns t1 t2
                     modCol (t1++t2) (rowToColumn filasFinal)
                  where ft1 = columnToRow (extractCont t1)
                        ft2 = columnToRow (extractCont t2)
                        filasFinal = concat $ map filaPorTabla ft1
                        filaPorTabla x   = map (\y->filaPorFila x y) ft2
                        filaPorFila  x y = x++y 

proyectar::Table -> [ColumnNameT] -> ARError Table
proyectar t []     = throw "Se debe proyectar al menos una columna."
proyectar t (x:xs) = do is <- lookUpsColumns (x:xs) (extractName t)
                        tf <- return $ map (\x-> t!!x) is
                        conservarUnicidad tf
                     where lookUpsColumns []     ys = return []
                           lookUpsColumns (x:xs) ys = do n  <- lookUpColumn x ys
                                                         ns <- lookUpsColumns xs ys
                                                         return ((n):ns)

renombre::String -> Table ->  ARError Table
renombre n t = do if repetidas==[] 
                    then return $ map (\((a,b),c)->((n,b),c)) t
                    else throw $ "Camibie los nombres de las columnas que se repiten en la siguiente lista\n"++(show nameRepeat)
               where equalCol ((a,b),c) ((w,x),y) = b==x
                     repetidas  = deleteFirstsBy equalCol t $ nubBy equalCol t
                     nameRepeat = map snd (extractName t)

renombreCol:: Table -> [(ColumnNameT,ColumnName)] -> ARError Table
renombreCol t []     = return t
renombreCol t (x:xs) = do i <- lookUpColumn ( fst x) (extractName t)
                          renombreCol (map (\n->if n==i then ((\((a,b),c)->((a,snd x),c)) (t!!n)) else t!!n) [0..((length t)-1)])xs
------------------------------------------------------------------------------------------------------
--COMPUESTAS------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

intersectT:: Table -> Table -> ARError Table
intersectT t1 t2 = do precondOp t1 t2
                      modCol t1 nt
                   where nt = rowToColumn (intersect (r t1) (r t2))
			 r  x  = columnToRow (cc x)
                         cc x  = extractCont x

natural:: Table -> Table -> ARError Table
natural t1 t2 = do checkNameColumns t1 t2
                   t  <- cartesiano t1 t2
                   ig <- select pred t
                   proyectar ig allColumns
                where
                   allColumns = unionBy (\(x1,x2)->(\(y1,y2)->x2==y2)) (extractName t1) (extractName t2)
                   pred = f columns
                   f [(n,n1,n2)]  =  Eq (n1,n) (Col (n2,n)) 
                   f (x:y:xs)     = And (f [x]) (f (y:xs))
                   columnsComun   = map snd (intersectBy isEqualCN nt1 nt2)
                   nt1 = extractName t1
                   nt2 = extractName t2
                   it1 = map (\x->indexador x nt1) columnsComun
                   it2 = map (\x->indexador x nt2) columnsComun
                   indexador _ []         = error "No deberia llegar aca funcion natural"
                   indexador x ((t,c):cs) = if isEqual x c then 0 else 1 + indexador x cs
                   columns = map (\i->(columnsComun!!i ,(fst (nt1!!(it1!!i))),(fst (nt2!!(it2!!i))) ) ) [0..((length columnsComun) -1)]


division:: Table -> Table -> ARError Table
division t1 t2 = do precondOpDiv t1 t2
                    tr1  <- proyectar  t1  rest 
                    tpr  <- cartesiano tr1 t2
                    trsr <- restaT (ord tpr) t1
                    tr2  <- proyectar trsr rest
                    restaT tr1 tr2
                 where nt1  = extractName t1
                       nt2  = extractName t2
                       com  = map (\(a,b)-> b )(intersectBy (\x->(\y-> (snd x)==(snd y))) nt1 nt2)
                       rest = filter (\x-> not (elem (snd x) com)) nt1
                       ord xs = map (\i->xs!!i) (map (\x-> f x xs) t1)
                       f ((a,b),c) xs = case findIndices (\((w,x),y)->isEqual b x) xs of
                                               [ ] -> error ("No existe la columna "++b++".\n")
                                               [n] -> n
                                               _   -> error ("Hay mas de una columna llamada "++b++".\n")
 

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------



checkNameColumns:: Table -> Table -> ARError ()
checkNameColumns t1 t2 = if nc==[] then return () else throw ("Se le debe cambiar el nombre a una de las tablas."++"\n")
                         where nc = intersectBy isEqualC (extractName t1) (extractName t2) 

conservarUnicidad :: Table -> ARError Table
conservarUnicidad t = modCol t newC 
                      where cond xs ys = and (map (\i->xs!!i==ys!!i) [0..((length t) -1)])
                            newC       = rowToColumn (nubBy cond (columnToRow (extractCont t)))




modifCont:: PredSystem -> Table -> ARError Table
modifCont p [] = return []
modifCont p t  = do bss <- filterM (\y-> satisface y p) bs
                    case bss of
                         []   -> return $ map (\i->( as!!i, f i)) [0..((length t)-1)]
                         jbss -> return $ map (\i->( as!!i,((rowToColumn bss)!!i))) [0..((length t)-1)]
                 where as = extractName t
                       bs = columnToRow $ extractCont t
                       f i = case (extractCont t)!!i of
                                  Left  _ -> Left  []
                                  Right _ -> Right []

--seleccionar scod="x" s

long::[Either [String] [Int]] -> Int
long []             = 0
long ((Left  x):xs) = length x
long ((Right x):xs) = length x

addLineF:: Linea -> [[Either String Int]]->[[Either String Int]]
addLineF l ls = nub (l:ls)

addLineC:: Linea -> [Either [String] [Int]]->[Either [String] [Int]]
addLineC l e = case (l             , e            )of
                    ([]            , []           )-> []
                    (((Left  a):as), (Left  ls):es)-> (Left  (a:ls):(addLineC as es))
                    (((Right a):as), (Right ls):es)-> (Right (a:ls):(addLineC as es))
                    ( _            , _            )-> error "No debería llegar acá, función addLine.\n Chekear los tipos."

ctr::Int -> [Either [String] [Int]] -> [Either String Int]
ctr i []     = []
ctr i (c:cs) = case c       of
                    Left  x -> (Left  (x!!i)): (ctr i cs )
                    Right x -> (Right (x!!i)): (ctr i cs )

columnToRow:: [Either [String] [Int]] -> [Linea]
columnToRow [] = []
columnToRow xs = map (\i-> ctr i xs) [0..((long xs) - 1)] 

rowToColumn:: [Linea] -> [Either [String] [Int]]
rowToColumn c = if length c == 0      then [] else--no deberia llegar aca, las tablas no pueden ser vacias
		if length (c!!0) == 0 then colsEmpty c else 
		cols (reverse c) (colsEmpty c )
                where  cols []     es = es
                       cols (c:cs) es = cols cs (addLineC c es)
                       colsEmpty   c  = map (\x-> case (c!!0)!!x of
                                                       Left  x -> Left  []
                                                       Right x -> Right [] ) ([0..((length (c!!0) )-1)])

modCol:: Table -> [Either [String] [Int]] -> ARError Table
modCol t xs = if (length xs)==0  
                then return $ map (\(a,b)->(a,f b)) t 
                else return $ map (\i->(tn!!i, xs!!i)) [0..((length xs)-1)]
              where tn = extractName t
                    f (Left  x) = Left  []
                    f (Right x) = Right []

precondOp:: Table -> Table -> ARError ()
precondOp c1 c2 = do compCol c1  c2
                     compTps cc1 cc2
                  where compTps xs ys = case (xs           , ys          ) of
                                             ([]           , []          ) -> return ()
                                             ((Left  x):xss,(Left  y):yss) -> (compTps xss yss)
                                             ((Right x):xss,(Right y):yss) -> (compTps xss yss)
                                             (_            ,_            ) -> throw "No coinciden los tipos de las columnas"
                        compCol x y = if (nameCols x)==(nameCols y) then return () else throw "No coinciden los nombres de las columnas"
                        cc1 = extractCont c1
                        cc2 = extractCont c2
                        nameCols x = map snd (extractName x)




precondOpDiv:: Table -> Table -> ARError ()
precondOpDiv c1 c2 = do compCol cn1 cn2
                        auxCompTps c1 c2
                     where compCol x y = if (noCont x y)==[] then return () else throw ("No coinciden los nombres de las columnas.\nLas columnas "++(show (noCont x y))++" no estan en la tabla a dividir.")
                           cn1  = map snd $extractName c1
                           cn2  = map snd $extractName c2
                           noCont x []     = []
                           noCont x (y:ys) = if (elem y x) then (noCont x ys) else y:(noCont x ys)

auxCompTps:: Table -> Table -> ARError ()                       
auxCompTps c1 c2 = compTps (cc1 ind) cc2 ind
                   where compTps xxs yys i =if ((length cn2)/=(length cn1f)) then throw myError else 
                              case (xxs         , yys        ) of
                                   ([]          , []         ) -> return ()
                                   ((Left  x):xs,(Left  y):ys) -> (compTps xs ys i)
                                   ((Right x):xs,(Right y):ys) -> (compTps xs ys i)
                                   ( x:xs       , y:ys       ) -> throw ("No coinciden los tipos de las columnas\n"++(show x)++"\n\n"++(show y))
                         ind   = inds pcn2 pcn1
                         pcn1  = extractName c1
                         pcn2  = extractName c2
                         cn1   = map snd pcn1
                         cn2   = map snd pcn2
                         cn1f  = (map (\x-> (cn1!!x)) ind )
                         cc1 i = extractCont (map (\x-> (c1!!x)) i )
                         cc2   = extractCont c2
                         inds cn d = concat $ map (\(_,n)->lookUpColumns ("",n) d) cn
                         myError   = "La tabla a dividir posee las siguientes columnas\n"++(show cn1)++"\nLa tabla divisora posee las siguientes columnas\n"++(show cn2)++"\n"++"Renombre las columnas que se repiten en la siguiente lista \n"++(show cn1f)   


satisface:: Linea -> PredSystem -> ARError Bool
satisface l (NotS p     )       = do pred  <- satisface l p
                                     return $not pred
satisface l (OrS  p1  p2)       = do pred1 <- satisface l p1
                                     pred2 <- satisface l p2
                                     return $ pred1 || pred2
satisface l (AndS p1  p2)       = do pred1 <- satisface l p1
                                     pred2 <- satisface l p2
                                     return $ pred1 && pred2
satisface l (EqS  c  (ColS c1)) = case ((l!!c), (l!!c1)) of
                                       (Left  c, Left  x) -> return $ isEqual c x
                                       (Right c, Right x) -> return $ c==x
                                       (_      , _      ) -> throw "Error: comparación entre String e Int."
satisface l (NES  c  (ColS c1)) = case ((l!!c), (l!!c1)) of
                                       (Left  c, Left  x) -> return $ not $ isEqual c x
                                       (Right c, Right x) -> return $ not $ c==x
                                       (_      , _      ) -> throw "Error: comparación entre String e Int."
satisface l (LES  c  (ColS c1)) = case (l!!c   , l!! c1 ) of 
                                       (Right x, Right y) -> return $ x<=y
                                       (_      , _      ) -> throw "Error: comparación entre String e Int."
satisface l (GES  c  (ColS c1)) = case (l!!c   , l!! c1 ) of 
                                       (Right x, Right y) -> return $ x>=y
                                       (_      , _      ) -> throw "Error: comparación entre String e Int."
satisface l (LtS  c  (ColS c1)) = case (l!!c   , l!! c1 ) of 
                                       (Right x, Right y) -> return $ x< y
                                       (_      , _      ) -> throw "Error: comparación entre String e Int."
satisface l (GtS  c  (ColS c1)) = case (l!!c   , l!! c1 ) of 
                                       (Right x, Right y) -> return $ x> y
                                       (_      , _      ) -> throw "Error: comparación entre String e Int."
satisface l (NES  c  (VSS   i)) = case (l!!c) of
                                       Left  c -> return $ not $ isEqual c i
                                       _       -> throw "Error: comparación entre String e Int."
satisface l (EqS  c  (VSS   i)) = case (l!!c) of
                                       Left  c -> return $ isEqual c i
                                       _       -> throw "Error: comparación entre String e Int."
satisface l (NES  c  (VIS   i)) = case (l!!c) of
                                       Right c -> return $ c/=i
                                       _       -> throw "Error: comparación entre String e Int."
satisface l (EqS  c  (VIS   i)) = case (l!!c) of
                                       Right c -> return $ c==i
                                       _       -> throw "Error: comparación entre String e Int."
satisface l (LES  c  (VIS   i)) = case (l!!c) of
                                       Right c -> return $ c<=i
                                       _       -> throw "Error: comparación entre String e Int."
satisface l (GES  c  (VIS   i)) = case (l!!c) of
                                       Right c -> return $ c>=i
                                       _       -> throw "Error: comparación entre String e Int."
satisface l (LtS  c  (VIS   i)) = case (l!!c) of
                                       Right c -> return $ c< i
                                       _       -> throw "Error: comparación entre String e Int."
satisface l (GtS  c  (VIS   i)) = case (l!!c) of
                                       Right c -> return $ c> i
                                       _       -> throw "Error: comparación entre String e Int."
satisface l x                   = throw "Error: comparación entre String e Int."




uToS:: [ColumnNameT] -> PredUser -> ARError PredSystem
uToS l (Not p    ) = do p1  <- uToS l p
                        return (NotS p1     )
uToS l (Or  p1 p2) = do ps1 <- (uToS l   p1 )
                        ps2 <- (uToS l   p2 )
                        return (OrS  ps1 ps2)
uToS l (And p1 p2) = do ps1 <- (uToS l   p1 )
                        ps2 <- (uToS l   p2 )
                        return (AndS ps1 ps2)
uToS l (Eq  c  v ) = do i   <- lookUpColumn c l
                        val <- vUToVs l v
                        return $ EqS i val
uToS l (NE  c  v ) = do i   <- lookUpColumn c l
                        val <- vUToVs l v
                        return $ NES i val
uToS l (LE  c  v ) = do i   <- lookUpColumn c l
                        val <- vUToVs l v
                        return $ LES i val
uToS l (GE  c  v ) = do i   <- lookUpColumn c l
                        val <- vUToVs l v
                        return $ GES i val
uToS l (Lt  c  v ) = do i   <- lookUpColumn c l
                        val <- vUToVs l v
                        return $ LtS i val
uToS l (Gt  c  v ) = do i   <- lookUpColumn c l
                        val <- vUToVs l v
                        return $ GtS i val

vUToVs:: [ColumnNameT] -> ValPredUser -> ARError ValPredSystem
vUToVs l (Col c) = do i<-lookUpColumn c l
                      return (ColS i)
vUToVs l (AS  s) = return (VSS s)
vUToVs l (AI  i) = return (VIS i)

lookUpColumn:: ColumnNameT -> [ColumnNameT] -> ARError Int
lookUpColumn ("" ,nc ) ns = case findIndices (\x-> isEqual (snd x) nc) ns of
                                 []       -> throw ("No existe la columna "++nc++" en la tabla seleccionada.")
                                 [x]      -> return x
                                 (x:y:xs) -> throw ("Se necesita el nombre de tabla, "++nc++" es columna de más de una tabla.")
lookUpColumn (nt ,nc ) ns = case findIndices (\x-> (isEqual(fst x) nt) && (isEqual (snd x) nc)) ns of
                                 []       -> throw ("No existe la columna "++nc++" proveniente de la tabla "++nt++".")
                                 [x]      -> return x
                                 (x:y:xs) -> throw ("Se necesita el renombre de una de las tablas, hay dos columnas con el nombre "++nt++" "++nc++".")

lookUpColumns:: ColumnNameT -> [ColumnNameT] -> [Int]
lookUpColumns ("" ,n ) ns = findIndices (\x->  isEqual (snd x) n) ns
lookUpColumns (nt ,n ) ns = findIndices (\x-> (isEqual(fst x) nt) && (isEqual (snd x) n)) ns
