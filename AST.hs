module AST where
import ASTTablas

data Operaciones   = TName        TableName
		   | Borrar	  TableName
                   | Seleccionar  PredUser      Operaciones
                   | Renombrar    TableName     Operaciones
                   | Asignar      TableName     Operaciones
                   | Proyectar   [ColumnNameT]  Operaciones
                   | Unir         Operaciones   Operaciones
                   | Restar       Operaciones   Operaciones
                   | Cartesiano   Operaciones   Operaciones
                   | Intersecar   Operaciones   Operaciones
                   | Natural      Operaciones   Operaciones
                   | Dividir      Operaciones   Operaciones
                   | RenombrarCol Operaciones [(ColumnNameT,ColumnName)]
                   deriving (Show, Eq)

data ValPredUser   = Col  ColumnNameT | AI Int | AS String deriving (Show, Eq)
data PredUser      = Not  PredUser
                   | Or   PredUser    PredUser
                   | And  PredUser    PredUser
                   | Eq   ColumnNameT ValPredUser
                   | NE   ColumnNameT ValPredUser
                   | LE   ColumnNameT ValPredUser
                   | GE   ColumnNameT ValPredUser
                   | Lt   ColumnNameT ValPredUser
                   | Gt   ColumnNameT ValPredUser
                   deriving (Show, Eq)

data ValPredSystem = ColS Int | VIS Int | VSS String deriving (Show, Eq)
data PredSystem    = NotS PredSystem
                   | OrS  PredSystem  PredSystem
                   | AndS PredSystem  PredSystem
                   | EqS  Int         ValPredSystem
                   | NES  Int         ValPredSystem
                   | LES  Int         ValPredSystem
                   | GES  Int         ValPredSystem
                   | LtS  Int         ValPredSystem
                   | GtS  Int         ValPredSystem
                   deriving (Show, Eq)
