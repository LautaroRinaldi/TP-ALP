{
module ParseTablas where
import ASTTablas
import Data.Maybe
import Data.Char
import ParseR
import ARError
}

%monad { P } { thenP } { returnP }
%name parseTables Archivo


%tokentype { Token }
%lexer {lexer} {TEOF}

%token
    '@'         { TAt }
    '/'         { TSep }
    ','         { TComa }
    '('         { TOpen }
    ')'         { TClose }
    TNAME       { TName $$ }
    TSTRING     { TString $$ }
    TTIPENUM    { TTNum }
    TTIPECHAR   { TTChar }
    TNUM        { TNum $$ }


%%

Archivo :: {Archivo} 
        :  Tabla Archivo                            { $1 : $2 }
        |  {- empty -}                              { [] }

Tabla   :: { Tabla }
        :  '@' TNAME '(' TDef ')'  TCont            { T $2 $4 (checkTypeCol $2 $4 $6) }

TDef    :: { Encabezados }
        :  Campo ',' TDef                           { $1 : $3 }
        |  Campo                                    { [$1] }

Campo   :: { Encabezado }
        :  TNAME '/' TTIPENUM                       { ($1 , TNumeric) }
        |  TNAME '/' TTIPECHAR                      { ($1 , TChar) }


TCont   :: { Contenido }
        :  TLine TCont                              { $1 : $2 }
	|  {- empty -}                              { [] }

TLine   :: { Linea }
        :  TCampo  ',' TLine                        { $1 : $3 }
        |  TCampo                                   { [$1] }

TCampo   :: { Either String Int }
        :   TSTRING                                 { Left $1 }
        |   TNUM                                    { Right $1 }

{




checkTypeCol:: String-> Encabezados -> Contenido -> ARError Contenido
checkTypeCol ns es cs = do (mapM_ (\i-> checkTypeCont ns (map snd es) (cs!!i) i) [0..((length cs)-1)])
                           return cs



checkTypeCont::String -> [Tipo] -> [Either String Int] -> Int -> ARError()
checkTypeCont ns []     []      i = return ()
checkTypeCont ns []     (e:ent) i = throw ("La fila " ++(show i)++" de la tabla "++ ns ++" contiene demasiadas entradas.") 
checkTypeCont ns (t:ts) []      i = throw ("Una fila "++(show i)++" de la tabla "++ ns ++" no contiene suficientes entradas.")
checkTypeCont ns (t:ts) (e:ent) i = case ( e       , t       ) of
                                         ((Left  x), TChar   ) -> checkTypeCont ns ts ent i
                                         ((Right x), TNumeric) -> checkTypeCont ns ts ent i
                                         ((Right x), TChar   ) -> throw ("En la fila "++(show i)++": "++(show x)++" no es de tipo String.")
                                         ((Left  x), TNumeric) -> throw ("En la fila "++(show i)++": "++ x ++" no es de tipo Int.\n"++show ent)

 

happyError :: P a
happyError = \ s i -> Failed $ "Linea "++(show (i::LineNumber))++": Error de parseo inmediatamente antes de:\n"++(s)



data Token =  TName String
             |TNum     Int  
             |TString  String
             |TAt
             |TSep
	     |TComa
             |TOpen
             |TClose
             |TTNum
             |TTChar
	     |TEOF
               deriving Show

----------------------------------
lexer cont s = case s of
                    [] -> cont TEOF []
                    ('\n':s)  ->  \line -> lexer cont s (line + 1)
                    (c:cs)
                          | isSpace c    -> lexer cont cs
                          | isAlpha c    -> lexVar (c:cs)
                          | isDigit c    -> lexDig (c:cs)
			  | isAlphaNum c -> lexVar (c:cs)
                    (',':'\n':cs) -> errLine cs
                    ('\'':cs)-> varSim cs
                    ('\"':cs)-> varDob cs
		    ('/':cs) -> cont TSep cs
                    (',':cs) -> cont TComa cs
                    ('(':cs) -> cont TOpen cs
                    (')':cs) -> cont TClose cs
                    ('@':cs) -> cont TAt cs
                    unknown -> \line -> Failed $ "Línea "++(show line)++": No se puede reconocer "++(show $ take 10 unknown)++ "..."
                    where lexVar cs = case (spanString isAlpha  cs ) of
                                           ("string",rest) -> cont TTChar  rest
                                           ("int",rest)    -> cont TTNum   rest
                                           (name,rest)     -> cont (TName name) rest
		          lexDig cs = case span isDigit cs of
		                                   (num,rest)   -> cont (TNum (read num)) rest
                    	  varSim cs = let (txt,rest) = span (\x-> x/='\'') cs in (if (hayEnter txt) then \line -> Failed $ "Línea "++(show line)++": Contiene \\n en nombre de variable (texto:"++txt++rest++")\n" else  
				   if head rest/='\'' then \line -> Failed $ "Línea "++(show line)++": Nunca cierra ' en nombre de variable" else cont (TString txt) (tail rest))
                    	  varDob cs = let (txt,rest) = span (\x-> x/='\"') cs in (if (hayEnter txt) then \line -> Failed $ "Línea "++(show line)++": Contiene \\n en nombre de variable (texto:"++txt++rest++")\n" else  
				   if head rest/='\"' then \line -> Failed $ "Línea "++(show line)++": Nunca cierra ' en nombre de variable" else cont (TString txt) (tail rest))
                          errLine cs = \line -> Failed $ "Línea "++(show line)++": Posibles errores:\nFalta un argumento\nSobra una coma (',')"
		          hayEnter = elem '\n'
tables_parse s = parseTables s 1


}
