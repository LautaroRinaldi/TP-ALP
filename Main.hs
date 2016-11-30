{-# OPTIONS -XRecordWildCards #-}
module Main where

  import Control.Exception (catch,IOException)
  import Control.Applicative ((<|>))
  import Control.Monad (when)
  import Data.Char
  import Data.List
  import Prelude hiding (print, catch)
  import System.IO.Unsafe
  import System.Console.Terminfo
  import System.Console.Haskeline hiding (catch)
  import System.Environment
  import ParseR
  import Eval
  import AST
  import ASTTablas
  import Operaciones
  import Parse
  import ParseTablas
  import Tables
  import ARError
  import PrettyPrinter

---------------------
--- Interpreter
---------------------

  main :: IO ()
  main = do args <- getArgs
            readevalprint args (S "" [])


  ioExceptionCatcher :: IOException -> IO (Maybe a)
  ioExceptionCatcher _ = return Nothing


  data State = S { lfile :: String,     -- Ultimo archivo cargado (para hacer "reload")
                   tablas :: DB         -- Todas las NameTablas cargadas
                 }

  addState::NamedTable -> State -> State
  addState t@(Tab "ans" x) state@(S {..}) =state {tablas=t:(deleteBy (\(Tab a b)->(\(Tab c d) -> isEqual a c)) t tablas )}
  addState t               state@(S {..}) =state {tablas=t:tablas}

  eraseTabla::TableName -> State -> State
  eraseTabla t state@(S {..}) =state {tablas= filter (\(Tab n c)-> n/=t) tablas}


  iname, iprompt :: String
  iname = "Interprete de algebra relacional"
  iprompt = "AR> "

  readevalprint :: [String] -> State -> IO ()
  readevalprint args state@(S {..}) =
   do runInputT defaultSettings $ outputStrLn $ ( iname ++ ".\n Escriba :h para recibir ayuda o :? para ayuda con los operadores de algebra relacional.") 
      runInputT defaultSettings (loop state)
   where 
       loop :: State -> InputT IO ()
       loop st = do minput <- getInputLine iprompt
                    case minput of
                         Nothing -> return ()
                         Just "quit" -> loop st
                         Just input -> do c   <- return $ interpretCommand input
                                          st' <- return $ handleCommand st c
                                          maybe (return ()) loop $ unsafePerformIO st'--inseguro pero no se como arreglarlo, handleCommand no tiene errores

  data Command = Compile  String        --ejecute una operacion
               | Print    String        --imprime una tabla
               | PrintBD                --imprime toda la base de datos
               | PrintCol String        --imprime los nombres de columna completos de una tabla
               | Reload                 --Vuelve a cargar un archivo con tablas
               | Quit                   --salir
               | Help                   --ayuda
               | HelpOp                 --ayuda Algebra relacional
               | View                   --tablas el estado de la base de datos (tablas cargadas)
               | Noop                   --no hace nada
               | Load     String        --Carga un archivo que contiene tablas
               | Reserved               --Mostrar palabras reservadas

  
  interpretCommand :: String -> IO Command
  interpretCommand x
    =  if isPrefixOf ":" x then
         do  let  (cmd,t')  =  break isSpace x
                  t         =  dropWhile isSpace t'
             let  matching  =  filter (\ (Cmd cs _ _ _) -> any (isPrefixOf cmd) cs) commands
             case matching of
               []  ->  do  putStrLn ("Comando desconocido `" ++ 
                                     cmd                     ++ 
                                     "'.\n Escriba :h para recibir ayuda.")
                           return Noop
               [Cmd _ _ f _]
                   ->  do  return (f t)
               _   ->  do  putStrLn ("Comando ambigüo, podría ser " ++ 
                                     concat (intersperse ", " [ head cs | Cmd cs _ _ _ <- matching ]) ++ ".")
                           return Noop
                                                        
       else
           return (Compile x) <|> return Noop


  getOutARError :: ARError a -> IO (Maybe a)
  getOutARError x = case run x of
                         Right y -> return $ Just y
                         Left  y -> do putStrLn y
                                       return $ Nothing


  unionBD:: DB -> DB -> IO DB
  unionBD n o = if ((length n)+(length o)) == (length tabla)
                then return tabla 
                else do putStrLn $ "Tabla no cargada.\n Las tablas "++ns++" ya están cargadas."
                        return o
                where tabla = unionBy     (\(Tab n1 _)->(\(Tab n2 _)->isEqual n1 n2)) n o
                      com   = intersectBy (\(Tab n1 _)->(\(Tab n2 _)->isEqual n1 n2)) n o
                      ns    = filter (\x->x/='[' && x/=']') $show (extracNameNamedTable com)

  handleCommand :: State -> IO Command -> IO (Maybe State)
  handleCommand state@(S {..}) c =  
    do cmd <- c
       case cmd of
         Load    f  ->  do return (state {lfile=f })
                           s   <- readFile f <|> do putStrLn ("El archivo "++f++" no existe.")
                                                    return ""
                           par <- (parseIO "<interactive>" tables_parse s) <|> (return Nothing)
                           case par of
                                Nothing -> (handleCommand state (return Noop))
                                Just db -> do mnt <- getOutARError $ transform db
                                              case mnt of
                                                   Just nt -> do nBD <- unionBD nt tablas
                                                                 return (Just ( state { tablas = nBD } ))
                                                   Nothing -> do putStrLn ("El archivo "++f++" no es valido.")
                                                                 handleCommand state (return Noop)
         Quit       ->  (putStrLn "Saliendo...") >> return Nothing
         Noop       ->  return $ Just state
         View       ->  if tablas==[] 
                          then do putStrLn "No hay ninguna tabla cargada"
                                  return $ Just state
                          else do printNameDB tablas
                                  return $ Just state
         Help       ->  do putStr (helpTxt commands)
                           return $ Just state
         HelpOp     ->  do mapM_ putStr commandsOp
                           return $ Just state
         Compile c  ->  do newState <- ((compilePhrase state c) <|> (return state))
                           return $ Just newState
         Print s    ->  do printTab state s
                           return $ Just state
         PrintBD    ->  do printBD tablas
                           return $ Just state
         Reserved   ->  do mapM_ putStr ((intersperse ", "palabrasReservadas)++["\n"])
                           return $ Just state
         PrintCol s ->  do printCol state s
                           return $ Just state
         Reload     ->  if null lfile 
                        then putStrLn "No hay un archivo cargado.\n" >> 
                             return ( Just state )
                        else handleCommand state (return (Load lfile))

  data InteractiveCommand = Cmd [String] String (String -> Command) String

  commands :: [InteractiveCommand]
  commands
    =   [ 
         Cmd [":view"]        ""        (const View)            "Ver las tablas cargadas",
         Cmd [":load"]        "<file>"  Load                    "Cargar una base de datos desde un archivo",
         Cmd [":compile"]     "<file>"  Compile                 "Realizar operaciones desde un archivo",
         Cmd [":print"]       "<table>" Print                   "Imprime una tabla",
         Cmd [":columnsOf"]   "<table>" PrintCol                "Imprime una todas las columnas de una tabla",
         Cmd [":BDprint"]     ""        (const PrintBD)         "Imprime la base de datos actual",
         Cmd [":reload"]      "<file>"  (const Reload)          "Volver a cargar el último archivo",
         Cmd [":quit"]        ""        (const Quit)            "Salir del intérprete",
         Cmd [":help"]        ""        (const Help)            "Mostrar la lista de comandos",
         Cmd [":ophelp",":?"] ""        (const HelpOp)          "Mostrar la lista de operaciones sobre tablas",
         Cmd [":reserved"]    ""        (const Reserved)        "Mostrar la lista de palabras reservadas"
        ]


  commandsOp :: [String]
  commandsOp
    =   [ 
         "\n<name> := <operacion>\n",         
         "Crear la tabla <name> con el resultado de <operacion>, no puede realizarse dentro de una operacion. \n",
         "A la última tabla mostrada se puede encontrar con el nombre ans\n\n",
         "Borrar        ",  "<string>    (con all borra toda la base de datos)\n",
         "Seleccionar   ",  "<predicado>             ",  "<tabla>", "\n",
         "Proyectar     ",  "<columnas>              ",  "<tabla>", "\n",
         "Unir          ",  "<tabla>                 ",  "<tabla>", "\n",
         "Restar        ",  "<tabla>                 ",  "<tabla>", "\n",
         "Cartesiano    ",  "<tabla>                 ",  "<tabla>", "\n",
         "Natural       ",  "<tabla>                 ",  "<tabla>", "\n",
         "Intersecar    ",  "<tabla>                 ",  "<tabla>", "\n",
         "Dividir       ",  "<tabla>                 ",  "<tabla>", "\n",
         "Renombrar     ",  "<string>                ",  "<tabla>", "\n",
         "RenombrarCol  ",  "[(<columnas>,<string>)] ",  "<tabla>", "\n\n",
         "Donde:\n",
         "<predicado>  =",  "and <predicado> <predicado>          ","\n",
         "             |",  "or  <predicado> <predicado>          ","\n",
         "             |",  "not <predicado>                      ","\n",
         "             |",  "columna   =   columna/int/\"string\" ","\n",
         "             |",  "columna  /=   columna/int/\"string\" ","\n",
         "             |",  "columna   <   columna/int            ","\n",
         "             |",  "columna  <=   columna/int            ","\n",
         "             |",  "columna   >   columna/int            ","\n",
         "             |",  "columna  >=   columna/int            ","\n\n",
         "<columna>    =",  "string         ,el nombre de la columna","\n",
         "             |",  "string.string  ,nombre de tabla \".\" nombre de columna","\n",
         "<tabla>      =",  "nombre de tabla                             \n",
         "             |",  "operacion                                   \n"
        ]
  
  helpTxt :: [InteractiveCommand] -> String
  helpTxt cs
    =  "Lista de comandos:  Cualquier comando puede ser abreviado a :c donde\n" ++
       "c es el primer caracter del nombre completo.\n\n" ++
       "<operacion>             realiza una operacion\n" ++

       unlines (map (\ (Cmd c a _ d) -> 
                     let  ct = concat (intersperse ", " (map (++ if null a then "" else " " ++ a) c))
                     in   ct ++ replicate ((24 - length ct) `max` 2) ' ' ++ d) cs)


  compilePhrase :: State -> String -> IO State
  compilePhrase state x = do  op <- parseIO "<interactive>" op_parse x
                              case op of 
                                   Nothing   -> return state
                                   Just oper -> handleTable state oper 

  printCol   :: State -> String -> IO ()
  printCol st@(S {..}) x = case tableOfDB tablas x of
                                   Just t  -> printColumns t
                                   Nothing -> putStrLn ("La tabla "++x++" no existe.")

  printTab   :: State -> String -> IO ()
  printTab st@(S {..}) x = case tableOfDB tablas x of
                                   Just t  -> printTable t
                                   Nothing -> putStrLn ("La tabla "++x++" no existe.")


  parseIO :: String -> (String -> ParseResult a) -> String -> IO (Maybe a)
  parseIO f p x = case p x of
                       Failed e  -> do putStrLn (f++": "++e) 
                                       return Nothing
                       Ok r      -> return (Just r)


  handleTable :: State -> Operaciones -> IO State
  handleTable state@(S {..}) op =   
        case op of 
             Borrar  n      -> if isEqual "all" n
                               then return $ state {tablas=[]}         
                               else return $ eraseTabla n state
             Asignar n oper -> do c <- getOutARError $checkNameT n  
                                  case c of
                                       Nothing -> return state
                                       Just () -> if any (\t-> (nameNamedTable t)==n) tablas
                                                  then do putStrLn ("Ya existe la tabla "++n++".")
                                                          return state
                                                  else do mt1 <- getOutARError $ evalOp tablas oper
                                                          case mt1 of 
                                                               Nothing -> do return state
                                                               Just t1 -> do printTable t1
                                                                             mtf <- getOutARError $ newNamedTable n t1
                                                                             case mtf of 
                                                                                  Nothing -> return state
                                                                                  Just tf -> return (addState tf state)
             oper           -> do mtf <- getOutARError $ evalOp tablas oper
                                  case mtf of 
                                       Nothing -> return state
                                       Just tf -> do printTable tf
                                                     return (addState (Tab "ans" tf) state)
 
