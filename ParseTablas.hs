{-# OPTIONS_GHC -w #-}
module ParseTablas where
import ASTTablas
import Data.Maybe
import Data.Char
import ParseR
import ARError
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.5

data HappyAbsSyn 
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 (Archivo)
	| HappyAbsSyn5 (Tabla)
	| HappyAbsSyn6 (Encabezados)
	| HappyAbsSyn7 (Encabezado)
	| HappyAbsSyn8 (Contenido)
	| HappyAbsSyn9 (Linea)
	| HappyAbsSyn10 (Either String Int)

{- to allow type-synonyms as our monads (likely
 - with explicitly-specified bind and return)
 - in Haskell98, it seems that with
 - /type M a = .../, then /(HappyReduction M)/
 - is not allowed.  But Happy is a
 - code-generator that can just substitute it.
type HappyReduction m = 
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> m HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> m HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> m HappyAbsSyn
-}

action_0,
 action_1,
 action_2,
 action_3,
 action_4,
 action_5,
 action_6,
 action_7,
 action_8,
 action_9,
 action_10,
 action_11,
 action_12,
 action_13,
 action_14,
 action_15,
 action_16,
 action_17,
 action_18,
 action_19,
 action_20,
 action_21,
 action_22,
 action_23,
 action_24 :: () => Int -> ({-HappyReduction (P) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> (P) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> (P) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> (P) HappyAbsSyn)

happyReduce_1,
 happyReduce_2,
 happyReduce_3,
 happyReduce_4,
 happyReduce_5,
 happyReduce_6,
 happyReduce_7,
 happyReduce_8,
 happyReduce_9,
 happyReduce_10,
 happyReduce_11,
 happyReduce_12,
 happyReduce_13 :: () => ({-HappyReduction (P) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> (P) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> (P) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> (P) HappyAbsSyn)

action_0 (11) = happyShift action_3
action_0 (4) = happyGoto action_4
action_0 (5) = happyGoto action_2
action_0 _ = happyReduce_2

action_1 (11) = happyShift action_3
action_1 (5) = happyGoto action_2
action_1 _ = happyFail

action_2 (11) = happyShift action_3
action_2 (4) = happyGoto action_6
action_2 (5) = happyGoto action_2
action_2 _ = happyReduce_2

action_3 (16) = happyShift action_5
action_3 _ = happyFail

action_4 (21) = happyAccept
action_4 _ = happyFail

action_5 (14) = happyShift action_7
action_5 _ = happyFail

action_6 _ = happyReduce_1

action_7 (16) = happyShift action_10
action_7 (6) = happyGoto action_8
action_7 (7) = happyGoto action_9
action_7 _ = happyFail

action_8 (15) = happyShift action_13
action_8 _ = happyFail

action_9 (13) = happyShift action_12
action_9 _ = happyReduce_5

action_10 (12) = happyShift action_11
action_10 _ = happyFail

action_11 (18) = happyShift action_20
action_11 (19) = happyShift action_21
action_11 _ = happyFail

action_12 (16) = happyShift action_10
action_12 (6) = happyGoto action_19
action_12 (7) = happyGoto action_9
action_12 _ = happyFail

action_13 (17) = happyShift action_17
action_13 (20) = happyShift action_18
action_13 (8) = happyGoto action_14
action_13 (9) = happyGoto action_15
action_13 (10) = happyGoto action_16
action_13 _ = happyReduce_9

action_14 _ = happyReduce_3

action_15 (17) = happyShift action_17
action_15 (20) = happyShift action_18
action_15 (8) = happyGoto action_23
action_15 (9) = happyGoto action_15
action_15 (10) = happyGoto action_16
action_15 _ = happyReduce_9

action_16 (13) = happyShift action_22
action_16 _ = happyReduce_11

action_17 _ = happyReduce_12

action_18 _ = happyReduce_13

action_19 _ = happyReduce_4

action_20 _ = happyReduce_6

action_21 _ = happyReduce_7

action_22 (17) = happyShift action_17
action_22 (20) = happyShift action_18
action_22 (9) = happyGoto action_24
action_22 (10) = happyGoto action_16
action_22 _ = happyFail

action_23 _ = happyReduce_8

action_24 _ = happyReduce_10

happyReduce_1 = happySpecReduce_2  4 happyReduction_1
happyReduction_1 (HappyAbsSyn4  happy_var_2)
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1 : happy_var_2
	)
happyReduction_1 _ _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_0  4 happyReduction_2
happyReduction_2  =  HappyAbsSyn4
		 ([]
	)

happyReduce_3 = happyReduce 6 5 happyReduction_3
happyReduction_3 ((HappyAbsSyn8  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TName happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (T happy_var_2 happy_var_4 (checkTypeCol happy_var_2 happy_var_4 happy_var_6)
	) `HappyStk` happyRest

happyReduce_4 = happySpecReduce_3  6 happyReduction_4
happyReduction_4 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1 : happy_var_3
	)
happyReduction_4 _ _ _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_1  6 happyReduction_5
happyReduction_5 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 ([happy_var_1]
	)
happyReduction_5 _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_3  7 happyReduction_6
happyReduction_6 _
	_
	(HappyTerminal (TName happy_var_1))
	 =  HappyAbsSyn7
		 ((happy_var_1 , TNumeric)
	)
happyReduction_6 _ _ _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_3  7 happyReduction_7
happyReduction_7 _
	_
	(HappyTerminal (TName happy_var_1))
	 =  HappyAbsSyn7
		 ((happy_var_1 , TChar)
	)
happyReduction_7 _ _ _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_2  8 happyReduction_8
happyReduction_8 (HappyAbsSyn8  happy_var_2)
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn8
		 (happy_var_1 : happy_var_2
	)
happyReduction_8 _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_0  8 happyReduction_9
happyReduction_9  =  HappyAbsSyn8
		 ([]
	)

happyReduce_10 = happySpecReduce_3  9 happyReduction_10
happyReduction_10 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_1 : happy_var_3
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_1  9 happyReduction_11
happyReduction_11 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn9
		 ([happy_var_1]
	)
happyReduction_11 _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_1  10 happyReduction_12
happyReduction_12 (HappyTerminal (TString happy_var_1))
	 =  HappyAbsSyn10
		 (Left happy_var_1
	)
happyReduction_12 _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_1  10 happyReduction_13
happyReduction_13 (HappyTerminal (TNum happy_var_1))
	 =  HappyAbsSyn10
		 (Right happy_var_1
	)
happyReduction_13 _  = notHappyAtAll 

happyNewToken action sts stk
	= lexer(\tk -> 
	let cont i = action i i tk (HappyState action) sts stk in
	case tk of {
	TEOF -> action 21 21 tk (HappyState action) sts stk;
	TAt -> cont 11;
	TSep -> cont 12;
	TComa -> cont 13;
	TOpen -> cont 14;
	TClose -> cont 15;
	TName happy_dollar_dollar -> cont 16;
	TString happy_dollar_dollar -> cont 17;
	TTNum -> cont 18;
	TTChar -> cont 19;
	TNum happy_dollar_dollar -> cont 20;
	_ -> happyError' tk
	})

happyError_ 21 tk = happyError' tk
happyError_ _ tk = happyError' tk

happyThen :: () => P a -> (a -> P b) -> P b
happyThen = (thenP)
happyReturn :: () => a -> P a
happyReturn = (returnP)
happyThen1 = happyThen
happyReturn1 :: () => a -> P a
happyReturn1 = happyReturn
happyError' :: () => (Token) -> P a
happyError' tk = (\token -> happyError) tk

parseTables = happySomeParser where
  happySomeParser = happyThen (happyParse action_0) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


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
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command-line>" #-}







# 1 "/usr/include/stdc-predef.h" 1 3 4

# 17 "/usr/include/stdc-predef.h" 3 4










































{-# LINE 7 "<command-line>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 

{-# LINE 13 "templates/GenericTemplate.hs" #-}

{-# LINE 46 "templates/GenericTemplate.hs" #-}








{-# LINE 67 "templates/GenericTemplate.hs" #-}

{-# LINE 77 "templates/GenericTemplate.hs" #-}

{-# LINE 86 "templates/GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 155 "templates/GenericTemplate.hs" #-}

-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

{-# LINE 256 "templates/GenericTemplate.hs" #-}
happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.

{-# LINE 322 "templates/GenericTemplate.hs" #-}
{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
