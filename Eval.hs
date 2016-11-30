module Eval where
import AST
import ASTTablas
import Tables
import ARError
import Operaciones
import Data.Char
import Data.List
import Control.Monad

tableOfDB::DB -> String -> Maybe Table
tableOfDB ev x = case find (\s-> isEqual (nameNamedTable s) x ) ev of
                          Just t -> Just $ contNamedTable t
                          Nothing-> Nothing

evalOp:: DB -> Operaciones -> ARError Table
evalOp db op = case op of
                    TName         t         -> case tableOfDB db t of
                                                    Just t  -> return t
                                                    Nothing -> throw ("La tabla "++t++" no existe.")
                    Seleccionar   p   op1   -> do t  <- evalOp db op1
                                                  select p t
                    Proyectar     c   op1   -> do t  <- evalOp db op1
                                                  proyectar t c
                    Unir          op1 op2   -> do t1 <- evalOp db op1
                                                  t2 <- evalOp db op2
                                                  unionT t1 t2
                    Restar        op1 op2   -> do t1 <- evalOp db op1
                                                  t2 <- evalOp db op2
                                                  restaT t1 t2
                    Cartesiano    op1 op2   -> do t1 <- evalOp db op1
                                                  t2 <- evalOp db op2
                                                  cartesiano t1 t2
                    Intersecar    op1 op2   -> do t1 <- evalOp db op1
                                                  t2 <- evalOp db op2
                                                  intersectT t1 t2
                    Natural       op1 op2   -> do t1 <- evalOp db op1
                                                  t2 <- evalOp db op2
                                                  natural t1 t2
                    Dividir       op1 op2   -> do t1 <- evalOp db op1
                                                  t2 <- evalOp db op2
                                                  division t1 t2
                    RenombrarCol  op  cs    -> do checkNameC $ map snd cs
						  t  <- evalOp db op
                                                  renombreCol t cs
                    Renombrar     n   op    -> do checkNameT n
						  t  <- evalOp db op
                                                  renombre n t
                    Asignar       _   _     -> throw "Las asignaciones se realizan antes de operar."
                    Borrar        _         -> throw "El borrado se realizan antes de operar."

