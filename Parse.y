{
module Parse where
import ParseR
import AST
import ASTTablas
import Data.Maybe
import Data.Char

}

%monad { P } { thenP } { returnP }
%name parseOp Comando


%tokentype { Token }
%lexer {lexer} {TEOF}

%token
    '.'          { TDot             }
    ','          { TComa            }
    '('          { TOpen            }
    ')'          { TClose           }
    '['          { TOCor            }
    ']'          { TCCor            }
    '='          { TEq              }
    '/='         { TNE              }
    '<'          { TLower           }
    '>'          { TGreater         }
    '<='         { TLowerOrEq       }
    '>='         { TGreaterOrEq     }
    ':='         { TAsignacion      }
    '\''         { TComSimple       }
    '\"'         { TComDoble        }
    OR           { TOr              }
    AND          { TAnd             }
    NOT          { TNot             } 
    ID           { TID           $$ }
    Int          { TInt          $$ }
    Seleccionar  { TSeleccionar     }
    Proyectar    { TProyectar       }
    Unir         { TUnir            }
    Renombrar    { TRenombrar       }
    Restar       { TRestar          }
    Cartesiano   { TCartesiano      }
    Intersecar   { TIntersecar      }
    Natural      { TNatural         }
    Dividir      { TDividir         }
    RenombrarCol { TRenombrarCol    }
    Borrar       { TBorrar          }

    

%nonassoc ':='
%right NOT
%left  AND
%left  OR 
%nonassoc '=' '/=' '<' '>' '<=' '>=' ':='
%nonassoc '.' 
%left ','
%%

Comando         :: { Operaciones }
                :    Asignacion                                       { $1 }
                |    Operaciones                                      { $1 }
                |    Eliminacion                                      { $1 }

Eliminacion     :: { Operaciones }
		:    Borrar         TableName                         { Borrar       $2    }

Asignacion      :: { Operaciones }
		:    TableName       ':='          Operaciones        { Asignar      $1 $3 }

Operaciones     :: { Operaciones } 
                :    TableName                                        { TName        $1    }
                |    Seleccionar    Pred          Operaciones         { Seleccionar  $2 $3 } 
                |    Proyectar      ColumnsName   Operaciones         { Proyectar    $2 $3 }
                |    Renombrar      TableName     Operaciones         { Renombrar    $2 $3 }
                |    Unir           Operaciones   Operaciones         { Unir         $2 $3 }
                |    Restar         Operaciones   Operaciones         { Restar       $2 $3 }
                |    Cartesiano     Operaciones   Operaciones         { Cartesiano   $2 $3 }
                |    Intersecar     Operaciones   Operaciones         { Intersecar   $2 $3 }
                |    Natural        Operaciones   Operaciones         { Natural      $2 $3 }
                |    Dividir        Operaciones   Operaciones         { Dividir      $2 $3 }
                |    RenombrarCol   ColumnNames   Operaciones         { RenombrarCol $3 $2 }

Pred            :: { PredUser }
                :    '(' Pred ')'                                     { $2 }
                |    NOT             Pred                             { Not $2    }
                |    Pred            AND           Pred               { And $1 $3 }
                |    Pred            OR            Pred               { Or  $1 $3 }
                |    ColNamePar      TOp           ColNamePar         { $2  $1 (Col $3) }
                |    ColNamePar      TOp           Int                { $2  $1 (AI  $3) }
                |    ColNamePar      TOp           Palabra            { $2  $1 (AS  $3) }

Palabra		:: { String }
		:    '\''    ID    '\''                               { $2 }
		|    '\"'    ID    '\"'                               { $2 }

TOp	        :: { ColumnNameT -> ValPredUser -> PredUser }
   	        :    TOpInt                                           { $1 }


TOpInt	        :: { ColumnNameT -> ValPredUser -> PredUser }
      	        :    TOpString                                        { $1 }
      	        |    '<'                                              { Lt }
      	        |    '>'                                              { Gt }
      	        |    '<='                                             { LE }
      	        |    '>='                                             { GE }

TOpString       :: { ColumnNameT -> ValPredUser -> PredUser }
                :    '='                                              { Eq }
                |    '/='                                             { NE }

ColumnNames     :: { [(ColumnNameT, String)] }
                :    '['      ']'                                     { [] }
                |    '[' Pars ']'                                     { $2 }

Pars	        ::{ [(ColumnNameT, String)] }
    	        :    Par                                              { [$1]   }
    	        |    Par ',' Pars                                     {  $1:$3 }

Par    	        ::{  (ColumnNameT, String)  }
                :    '(' ColNamePar ',' ID ')'                        { ($2,$4) }

ColumnsName     :: { [ColumnNameT] }
                :    '['          ']'                                 { [] }
                |    '['ColumnName']'                                 { $2 }

ColumnName      :: { [ColumnNameT] }
	        :     ColNamePar				      { [$1]}
                |     ColNamePar ','ColumnName                        { $1:$3 }

ColNamePar      :: { ColumnNameT }
                :    TableName '.' ID                                 { ($1,$3) }
                |    ID                                               { ([],$1) }

TableName       :: { TableName }
                :    ID                                               { $1 }


{



happyError :: P a
happyError = \ s i -> Failed $ "Linea "++(show (i::LineNumber))++": Error de parseo antes de:\n"++(s)++"\n Presione :? para recibir ayuda con los operedores o :h para recibir ayuda general.\n"



data Token =  TDot
            | TComa
            | TOpen
            | TClose
            | TOCor
            | TCCor
            | TEq
            | TNE
            | TLower
            | TGreater
            | TLowerOrEq
            | TGreaterOrEq
            | TOr
            | TAnd
            | TNot
            | TID               String
            | TInt              Int
            | TSeleccionar
            | TProyectar
            | TUnir
            | TRenombrar
            | TRestar
            | TCartesiano
            | TIntersecar
            | TComDoble
            | TComSimple
            | TNatural
            | TDividir
            | TRenombrarCol
	    | TAsignacion
            | TBorrar
            | TEOF
                  deriving Show

----------------------------------


lexer cont s = case s of
                    [] -> cont TEOF []
                    ('\n':s)  ->  \line -> lexer cont s (line + 1)
                    (c:cs)
                          | isSpace c -> lexer cont cs
                          | isAlpha c -> lexVar (c:cs)
                          | isDigit c -> lexDig (c:cs)
		    ('.':cs)     -> cont TDot          cs
                    (',':cs)     -> cont TComa         cs
                    ('(':cs)     -> cont TOpen         cs
                    (')':cs)     -> cont TClose        cs
                    ('[':cs)     -> cont TOCor         cs
                    (']':cs)     -> cont TCCor         cs
                    ('=':cs)     -> cont TEq           cs
                    (':':'=':cs) -> cont TAsignacion   cs
                    ('/':'=':cs) -> cont TNE           cs
                    ('<':'=':cs) -> cont TLowerOrEq    cs
                    ('>':'=':cs) -> cont TGreaterOrEq  cs
                    ('<':cs)     -> cont TLower        cs
                    ('>':cs)     -> cont TGreater      cs
                    ('\'':cs)    -> cont TComSimple    cs
                    ('\"':cs)    -> cont TComDoble     cs
                    unknown -> \line -> Failed $ "Línea "++(show line)++": No se puede reconocer "++(show $ take 10 unknown)++ "..."
                    where lexVar cs = case spanString (\x->(isAlpha x) || (isDigit x)) cs of
                                           ("or",rest           )-> cont TOr           rest
                                           ("and",rest          )-> cont TAnd          rest
                                           ("not",rest          )-> cont TNot          rest
                                           ("unir",rest         )-> cont TUnir         rest
                                           ("restar",rest       )-> cont TRestar       rest
                                           ("borrar",rest       )-> cont TBorrar       rest
                                           ("natural",rest      )-> cont TNatural      rest
                                           ("dividir",rest      )-> cont TDividir      rest
                                           ("renombrar",rest    )-> cont TRenombrar    rest
                                           ("proyectar",rest    )-> cont TProyectar    rest
                                           ("cartesiano",rest   )-> cont TCartesiano   rest
                                           ("intersecar",rest   )-> cont TIntersecar   rest
                                           ("seleccionar",rest  )-> cont TSeleccionar  rest
                                           ("renombrarcol",rest )-> cont TRenombrarCol rest
                                           (name,rest           )-> cont (TID name)    rest
		          lexDig cs = case span isDigit cs of
		                                  (num,rest)   -> cont (TInt (read num)) rest
                    	 
op_parse s = parseOp s 1

}

