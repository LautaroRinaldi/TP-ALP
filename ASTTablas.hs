module ASTTablas where
import ARError

type Archivo            = [Tabla]
data Tabla              = T String Encabezados (ARError Contenido) deriving (Show, Eq)
type Encabezados        = [ Encabezado ]
type Encabezado         = ( String, Tipo )
data Tipo               = TNumeric | TChar deriving (Show, Eq)
type Contenido 	        = [ Linea ]
type Linea              = [ Entrada ]
type Entrada            = Either String Int


type DB                 = [NamedTable]
data NamedTable         = Tab TableName Table deriving (Show, Eq)
type TableName          = String
type Table              = [ Column ]
type Column             = ( ColumnNameT , Either [String] [Int]) 
type ColumnNameT        = ( TableName, ColumnName )
type ColumnName         = String




