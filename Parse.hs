{-# OPTIONS_GHC -w #-}
module Parse where
import ParseR
import AST
import ASTTablas
import Data.Maybe
import Data.Char
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.5

data HappyAbsSyn 
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 (Operaciones)
	| HappyAbsSyn8 (PredUser)
	| HappyAbsSyn9 (String)
	| HappyAbsSyn10 (ColumnNameT -> ValPredUser -> PredUser)
	| HappyAbsSyn13 ([(ColumnNameT, String)])
	| HappyAbsSyn15 ((ColumnNameT, String))
	| HappyAbsSyn16 ([ColumnNameT])
	| HappyAbsSyn18 (ColumnNameT)
	| HappyAbsSyn19 (TableName)

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
 action_24,
 action_25,
 action_26,
 action_27,
 action_28,
 action_29,
 action_30,
 action_31,
 action_32,
 action_33,
 action_34,
 action_35,
 action_36,
 action_37,
 action_38,
 action_39,
 action_40,
 action_41,
 action_42,
 action_43,
 action_44,
 action_45,
 action_46,
 action_47,
 action_48,
 action_49,
 action_50,
 action_51,
 action_52,
 action_53,
 action_54,
 action_55,
 action_56,
 action_57,
 action_58,
 action_59,
 action_60,
 action_61,
 action_62,
 action_63,
 action_64,
 action_65,
 action_66,
 action_67,
 action_68,
 action_69,
 action_70,
 action_71,
 action_72,
 action_73,
 action_74,
 action_75,
 action_76,
 action_77,
 action_78,
 action_79,
 action_80,
 action_81,
 action_82,
 action_83,
 action_84,
 action_85,
 action_86,
 action_87,
 action_88,
 action_89,
 action_90,
 action_91,
 action_92,
 action_93,
 action_94 :: () => Int -> ({-HappyReduction (P) = -}
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
 happyReduce_13,
 happyReduce_14,
 happyReduce_15,
 happyReduce_16,
 happyReduce_17,
 happyReduce_18,
 happyReduce_19,
 happyReduce_20,
 happyReduce_21,
 happyReduce_22,
 happyReduce_23,
 happyReduce_24,
 happyReduce_25,
 happyReduce_26,
 happyReduce_27,
 happyReduce_28,
 happyReduce_29,
 happyReduce_30,
 happyReduce_31,
 happyReduce_32,
 happyReduce_33,
 happyReduce_34,
 happyReduce_35,
 happyReduce_36,
 happyReduce_37,
 happyReduce_38,
 happyReduce_39,
 happyReduce_40,
 happyReduce_41,
 happyReduce_42,
 happyReduce_43,
 happyReduce_44,
 happyReduce_45 :: () => ({-HappyReduction (P) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> (P) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> (P) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> (P) HappyAbsSyn)

action_0 (38) = happyShift action_4
action_0 (40) = happyShift action_9
action_0 (41) = happyShift action_10
action_0 (42) = happyShift action_11
action_0 (43) = happyShift action_12
action_0 (44) = happyShift action_13
action_0 (45) = happyShift action_14
action_0 (46) = happyShift action_15
action_0 (47) = happyShift action_16
action_0 (48) = happyShift action_17
action_0 (49) = happyShift action_18
action_0 (50) = happyShift action_19
action_0 (4) = happyGoto action_5
action_0 (5) = happyGoto action_6
action_0 (6) = happyGoto action_2
action_0 (7) = happyGoto action_7
action_0 (19) = happyGoto action_8
action_0 _ = happyFail

action_1 (38) = happyShift action_4
action_1 (6) = happyGoto action_2
action_1 (19) = happyGoto action_3
action_1 _ = happyFail

action_2 _ = happyReduce_1

action_3 (32) = happyShift action_39
action_3 _ = happyFail

action_4 _ = happyReduce_45

action_5 (51) = happyAccept
action_5 _ = happyFail

action_6 _ = happyReduce_3

action_7 _ = happyReduce_2

action_8 (32) = happyShift action_39
action_8 _ = happyReduce_6

action_9 (22) = happyShift action_36
action_9 (37) = happyShift action_37
action_9 (38) = happyShift action_38
action_9 (8) = happyGoto action_33
action_9 (18) = happyGoto action_34
action_9 (19) = happyGoto action_35
action_9 _ = happyFail

action_10 (24) = happyShift action_32
action_10 (16) = happyGoto action_31
action_10 _ = happyFail

action_11 (38) = happyShift action_4
action_11 (40) = happyShift action_9
action_11 (41) = happyShift action_10
action_11 (42) = happyShift action_11
action_11 (43) = happyShift action_12
action_11 (44) = happyShift action_13
action_11 (45) = happyShift action_14
action_11 (46) = happyShift action_15
action_11 (47) = happyShift action_16
action_11 (48) = happyShift action_17
action_11 (49) = happyShift action_18
action_11 (7) = happyGoto action_30
action_11 (19) = happyGoto action_24
action_11 _ = happyFail

action_12 (38) = happyShift action_4
action_12 (19) = happyGoto action_29
action_12 _ = happyFail

action_13 (38) = happyShift action_4
action_13 (40) = happyShift action_9
action_13 (41) = happyShift action_10
action_13 (42) = happyShift action_11
action_13 (43) = happyShift action_12
action_13 (44) = happyShift action_13
action_13 (45) = happyShift action_14
action_13 (46) = happyShift action_15
action_13 (47) = happyShift action_16
action_13 (48) = happyShift action_17
action_13 (49) = happyShift action_18
action_13 (7) = happyGoto action_28
action_13 (19) = happyGoto action_24
action_13 _ = happyFail

action_14 (38) = happyShift action_4
action_14 (40) = happyShift action_9
action_14 (41) = happyShift action_10
action_14 (42) = happyShift action_11
action_14 (43) = happyShift action_12
action_14 (44) = happyShift action_13
action_14 (45) = happyShift action_14
action_14 (46) = happyShift action_15
action_14 (47) = happyShift action_16
action_14 (48) = happyShift action_17
action_14 (49) = happyShift action_18
action_14 (7) = happyGoto action_27
action_14 (19) = happyGoto action_24
action_14 _ = happyFail

action_15 (38) = happyShift action_4
action_15 (40) = happyShift action_9
action_15 (41) = happyShift action_10
action_15 (42) = happyShift action_11
action_15 (43) = happyShift action_12
action_15 (44) = happyShift action_13
action_15 (45) = happyShift action_14
action_15 (46) = happyShift action_15
action_15 (47) = happyShift action_16
action_15 (48) = happyShift action_17
action_15 (49) = happyShift action_18
action_15 (7) = happyGoto action_26
action_15 (19) = happyGoto action_24
action_15 _ = happyFail

action_16 (38) = happyShift action_4
action_16 (40) = happyShift action_9
action_16 (41) = happyShift action_10
action_16 (42) = happyShift action_11
action_16 (43) = happyShift action_12
action_16 (44) = happyShift action_13
action_16 (45) = happyShift action_14
action_16 (46) = happyShift action_15
action_16 (47) = happyShift action_16
action_16 (48) = happyShift action_17
action_16 (49) = happyShift action_18
action_16 (7) = happyGoto action_25
action_16 (19) = happyGoto action_24
action_16 _ = happyFail

action_17 (38) = happyShift action_4
action_17 (40) = happyShift action_9
action_17 (41) = happyShift action_10
action_17 (42) = happyShift action_11
action_17 (43) = happyShift action_12
action_17 (44) = happyShift action_13
action_17 (45) = happyShift action_14
action_17 (46) = happyShift action_15
action_17 (47) = happyShift action_16
action_17 (48) = happyShift action_17
action_17 (49) = happyShift action_18
action_17 (7) = happyGoto action_23
action_17 (19) = happyGoto action_24
action_17 _ = happyFail

action_18 (24) = happyShift action_22
action_18 (13) = happyGoto action_21
action_18 _ = happyFail

action_19 (38) = happyShift action_4
action_19 (19) = happyGoto action_20
action_19 _ = happyFail

action_20 _ = happyReduce_4

action_21 (38) = happyShift action_4
action_21 (40) = happyShift action_9
action_21 (41) = happyShift action_10
action_21 (42) = happyShift action_11
action_21 (43) = happyShift action_12
action_21 (44) = happyShift action_13
action_21 (45) = happyShift action_14
action_21 (46) = happyShift action_15
action_21 (47) = happyShift action_16
action_21 (48) = happyShift action_17
action_21 (49) = happyShift action_18
action_21 (7) = happyGoto action_71
action_21 (19) = happyGoto action_24
action_21 _ = happyFail

action_22 (22) = happyShift action_69
action_22 (25) = happyShift action_70
action_22 (14) = happyGoto action_67
action_22 (15) = happyGoto action_68
action_22 _ = happyFail

action_23 (38) = happyShift action_4
action_23 (40) = happyShift action_9
action_23 (41) = happyShift action_10
action_23 (42) = happyShift action_11
action_23 (43) = happyShift action_12
action_23 (44) = happyShift action_13
action_23 (45) = happyShift action_14
action_23 (46) = happyShift action_15
action_23 (47) = happyShift action_16
action_23 (48) = happyShift action_17
action_23 (49) = happyShift action_18
action_23 (7) = happyGoto action_66
action_23 (19) = happyGoto action_24
action_23 _ = happyFail

action_24 _ = happyReduce_6

action_25 (38) = happyShift action_4
action_25 (40) = happyShift action_9
action_25 (41) = happyShift action_10
action_25 (42) = happyShift action_11
action_25 (43) = happyShift action_12
action_25 (44) = happyShift action_13
action_25 (45) = happyShift action_14
action_25 (46) = happyShift action_15
action_25 (47) = happyShift action_16
action_25 (48) = happyShift action_17
action_25 (49) = happyShift action_18
action_25 (7) = happyGoto action_65
action_25 (19) = happyGoto action_24
action_25 _ = happyFail

action_26 (38) = happyShift action_4
action_26 (40) = happyShift action_9
action_26 (41) = happyShift action_10
action_26 (42) = happyShift action_11
action_26 (43) = happyShift action_12
action_26 (44) = happyShift action_13
action_26 (45) = happyShift action_14
action_26 (46) = happyShift action_15
action_26 (47) = happyShift action_16
action_26 (48) = happyShift action_17
action_26 (49) = happyShift action_18
action_26 (7) = happyGoto action_64
action_26 (19) = happyGoto action_24
action_26 _ = happyFail

action_27 (38) = happyShift action_4
action_27 (40) = happyShift action_9
action_27 (41) = happyShift action_10
action_27 (42) = happyShift action_11
action_27 (43) = happyShift action_12
action_27 (44) = happyShift action_13
action_27 (45) = happyShift action_14
action_27 (46) = happyShift action_15
action_27 (47) = happyShift action_16
action_27 (48) = happyShift action_17
action_27 (49) = happyShift action_18
action_27 (7) = happyGoto action_63
action_27 (19) = happyGoto action_24
action_27 _ = happyFail

action_28 (38) = happyShift action_4
action_28 (40) = happyShift action_9
action_28 (41) = happyShift action_10
action_28 (42) = happyShift action_11
action_28 (43) = happyShift action_12
action_28 (44) = happyShift action_13
action_28 (45) = happyShift action_14
action_28 (46) = happyShift action_15
action_28 (47) = happyShift action_16
action_28 (48) = happyShift action_17
action_28 (49) = happyShift action_18
action_28 (7) = happyGoto action_62
action_28 (19) = happyGoto action_24
action_28 _ = happyFail

action_29 (38) = happyShift action_4
action_29 (40) = happyShift action_9
action_29 (41) = happyShift action_10
action_29 (42) = happyShift action_11
action_29 (43) = happyShift action_12
action_29 (44) = happyShift action_13
action_29 (45) = happyShift action_14
action_29 (46) = happyShift action_15
action_29 (47) = happyShift action_16
action_29 (48) = happyShift action_17
action_29 (49) = happyShift action_18
action_29 (7) = happyGoto action_61
action_29 (19) = happyGoto action_24
action_29 _ = happyFail

action_30 (38) = happyShift action_4
action_30 (40) = happyShift action_9
action_30 (41) = happyShift action_10
action_30 (42) = happyShift action_11
action_30 (43) = happyShift action_12
action_30 (44) = happyShift action_13
action_30 (45) = happyShift action_14
action_30 (46) = happyShift action_15
action_30 (47) = happyShift action_16
action_30 (48) = happyShift action_17
action_30 (49) = happyShift action_18
action_30 (7) = happyGoto action_60
action_30 (19) = happyGoto action_24
action_30 _ = happyFail

action_31 (38) = happyShift action_4
action_31 (40) = happyShift action_9
action_31 (41) = happyShift action_10
action_31 (42) = happyShift action_11
action_31 (43) = happyShift action_12
action_31 (44) = happyShift action_13
action_31 (45) = happyShift action_14
action_31 (46) = happyShift action_15
action_31 (47) = happyShift action_16
action_31 (48) = happyShift action_17
action_31 (49) = happyShift action_18
action_31 (7) = happyGoto action_59
action_31 (19) = happyGoto action_24
action_31 _ = happyFail

action_32 (25) = happyShift action_58
action_32 (38) = happyShift action_38
action_32 (17) = happyGoto action_56
action_32 (18) = happyGoto action_57
action_32 (19) = happyGoto action_35
action_32 _ = happyFail

action_33 (35) = happyShift action_54
action_33 (36) = happyShift action_55
action_33 (38) = happyShift action_4
action_33 (40) = happyShift action_9
action_33 (41) = happyShift action_10
action_33 (42) = happyShift action_11
action_33 (43) = happyShift action_12
action_33 (44) = happyShift action_13
action_33 (45) = happyShift action_14
action_33 (46) = happyShift action_15
action_33 (47) = happyShift action_16
action_33 (48) = happyShift action_17
action_33 (49) = happyShift action_18
action_33 (7) = happyGoto action_53
action_33 (19) = happyGoto action_24
action_33 _ = happyFail

action_34 (26) = happyShift action_47
action_34 (27) = happyShift action_48
action_34 (28) = happyShift action_49
action_34 (29) = happyShift action_50
action_34 (30) = happyShift action_51
action_34 (31) = happyShift action_52
action_34 (10) = happyGoto action_44
action_34 (11) = happyGoto action_45
action_34 (12) = happyGoto action_46
action_34 _ = happyFail

action_35 (20) = happyShift action_43
action_35 _ = happyFail

action_36 (22) = happyShift action_36
action_36 (37) = happyShift action_37
action_36 (38) = happyShift action_38
action_36 (8) = happyGoto action_42
action_36 (18) = happyGoto action_34
action_36 (19) = happyGoto action_35
action_36 _ = happyFail

action_37 (22) = happyShift action_36
action_37 (37) = happyShift action_37
action_37 (38) = happyShift action_38
action_37 (8) = happyGoto action_41
action_37 (18) = happyGoto action_34
action_37 (19) = happyGoto action_35
action_37 _ = happyFail

action_38 (21) = happyReduce_44
action_38 (23) = happyReduce_44
action_38 (25) = happyReduce_44
action_38 (26) = happyReduce_44
action_38 (27) = happyReduce_44
action_38 (28) = happyReduce_44
action_38 (29) = happyReduce_44
action_38 (30) = happyReduce_44
action_38 (31) = happyReduce_44
action_38 (35) = happyReduce_44
action_38 (36) = happyReduce_44
action_38 (38) = happyReduce_44
action_38 (40) = happyReduce_44
action_38 (41) = happyReduce_44
action_38 (42) = happyReduce_44
action_38 (43) = happyReduce_44
action_38 (44) = happyReduce_44
action_38 (45) = happyReduce_44
action_38 (46) = happyReduce_44
action_38 (47) = happyReduce_44
action_38 (48) = happyReduce_44
action_38 (49) = happyReduce_44
action_38 _ = happyReduce_45

action_39 (38) = happyShift action_4
action_39 (40) = happyShift action_9
action_39 (41) = happyShift action_10
action_39 (42) = happyShift action_11
action_39 (43) = happyShift action_12
action_39 (44) = happyShift action_13
action_39 (45) = happyShift action_14
action_39 (46) = happyShift action_15
action_39 (47) = happyShift action_16
action_39 (48) = happyShift action_17
action_39 (49) = happyShift action_18
action_39 (7) = happyGoto action_40
action_39 (19) = happyGoto action_24
action_39 _ = happyFail

action_40 _ = happyReduce_5

action_41 (35) = happyShift action_54
action_41 (36) = happyShift action_55
action_41 _ = happyReduce_18

action_42 (23) = happyShift action_85
action_42 (35) = happyShift action_54
action_42 (36) = happyShift action_55
action_42 _ = happyFail

action_43 (38) = happyShift action_84
action_43 _ = happyFail

action_44 (33) = happyShift action_81
action_44 (34) = happyShift action_82
action_44 (38) = happyShift action_38
action_44 (39) = happyShift action_83
action_44 (9) = happyGoto action_79
action_44 (18) = happyGoto action_80
action_44 (19) = happyGoto action_35
action_44 _ = happyFail

action_45 _ = happyReduce_26

action_46 _ = happyReduce_27

action_47 _ = happyReduce_32

action_48 _ = happyReduce_33

action_49 _ = happyReduce_28

action_50 _ = happyReduce_29

action_51 _ = happyReduce_30

action_52 _ = happyReduce_31

action_53 _ = happyReduce_7

action_54 (22) = happyShift action_36
action_54 (37) = happyShift action_37
action_54 (38) = happyShift action_38
action_54 (8) = happyGoto action_78
action_54 (18) = happyGoto action_34
action_54 (19) = happyGoto action_35
action_54 _ = happyFail

action_55 (22) = happyShift action_36
action_55 (37) = happyShift action_37
action_55 (38) = happyShift action_38
action_55 (8) = happyGoto action_77
action_55 (18) = happyGoto action_34
action_55 (19) = happyGoto action_35
action_55 _ = happyFail

action_56 (25) = happyShift action_76
action_56 _ = happyFail

action_57 (21) = happyShift action_75
action_57 _ = happyReduce_41

action_58 _ = happyReduce_39

action_59 _ = happyReduce_8

action_60 _ = happyReduce_10

action_61 _ = happyReduce_9

action_62 _ = happyReduce_11

action_63 _ = happyReduce_12

action_64 _ = happyReduce_13

action_65 _ = happyReduce_14

action_66 _ = happyReduce_15

action_67 (25) = happyShift action_74
action_67 _ = happyFail

action_68 (21) = happyShift action_73
action_68 _ = happyReduce_36

action_69 (38) = happyShift action_38
action_69 (18) = happyGoto action_72
action_69 (19) = happyGoto action_35
action_69 _ = happyFail

action_70 _ = happyReduce_34

action_71 _ = happyReduce_16

action_72 (21) = happyShift action_90
action_72 _ = happyFail

action_73 (22) = happyShift action_69
action_73 (14) = happyGoto action_89
action_73 (15) = happyGoto action_68
action_73 _ = happyFail

action_74 _ = happyReduce_35

action_75 (38) = happyShift action_38
action_75 (17) = happyGoto action_88
action_75 (18) = happyGoto action_57
action_75 (19) = happyGoto action_35
action_75 _ = happyFail

action_76 _ = happyReduce_40

action_77 (35) = happyShift action_54
action_77 _ = happyReduce_19

action_78 _ = happyReduce_20

action_79 _ = happyReduce_23

action_80 _ = happyReduce_21

action_81 (38) = happyShift action_87
action_81 _ = happyFail

action_82 (38) = happyShift action_86
action_82 _ = happyFail

action_83 _ = happyReduce_22

action_84 _ = happyReduce_43

action_85 _ = happyReduce_17

action_86 (34) = happyShift action_93
action_86 _ = happyFail

action_87 (33) = happyShift action_92
action_87 _ = happyFail

action_88 _ = happyReduce_42

action_89 _ = happyReduce_37

action_90 (38) = happyShift action_91
action_90 _ = happyFail

action_91 (23) = happyShift action_94
action_91 _ = happyFail

action_92 _ = happyReduce_24

action_93 _ = happyReduce_25

action_94 _ = happyReduce_38

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_1  4 happyReduction_2
happyReduction_2 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1  4 happyReduction_3
happyReduction_3 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_2  5 happyReduction_4
happyReduction_4 (HappyAbsSyn19  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (Borrar       happy_var_2
	)
happyReduction_4 _ _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_3  6 happyReduction_5
happyReduction_5 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn4
		 (Asignar      happy_var_1 happy_var_3
	)
happyReduction_5 _ _ _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_1  7 happyReduction_6
happyReduction_6 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn4
		 (TName        happy_var_1
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_3  7 happyReduction_7
happyReduction_7 (HappyAbsSyn4  happy_var_3)
	(HappyAbsSyn8  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (Seleccionar  happy_var_2 happy_var_3
	)
happyReduction_7 _ _ _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_3  7 happyReduction_8
happyReduction_8 (HappyAbsSyn4  happy_var_3)
	(HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (Proyectar    happy_var_2 happy_var_3
	)
happyReduction_8 _ _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_3  7 happyReduction_9
happyReduction_9 (HappyAbsSyn4  happy_var_3)
	(HappyAbsSyn19  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (Renombrar    happy_var_2 happy_var_3
	)
happyReduction_9 _ _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_3  7 happyReduction_10
happyReduction_10 (HappyAbsSyn4  happy_var_3)
	(HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (Unir         happy_var_2 happy_var_3
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_3  7 happyReduction_11
happyReduction_11 (HappyAbsSyn4  happy_var_3)
	(HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (Restar       happy_var_2 happy_var_3
	)
happyReduction_11 _ _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_3  7 happyReduction_12
happyReduction_12 (HappyAbsSyn4  happy_var_3)
	(HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (Cartesiano   happy_var_2 happy_var_3
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_3  7 happyReduction_13
happyReduction_13 (HappyAbsSyn4  happy_var_3)
	(HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (Intersecar   happy_var_2 happy_var_3
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_3  7 happyReduction_14
happyReduction_14 (HappyAbsSyn4  happy_var_3)
	(HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (Natural      happy_var_2 happy_var_3
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_3  7 happyReduction_15
happyReduction_15 (HappyAbsSyn4  happy_var_3)
	(HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (Dividir      happy_var_2 happy_var_3
	)
happyReduction_15 _ _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_3  7 happyReduction_16
happyReduction_16 (HappyAbsSyn4  happy_var_3)
	(HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (RenombrarCol happy_var_3 happy_var_2
	)
happyReduction_16 _ _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_3  8 happyReduction_17
happyReduction_17 _
	(HappyAbsSyn8  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (happy_var_2
	)
happyReduction_17 _ _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_2  8 happyReduction_18
happyReduction_18 (HappyAbsSyn8  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (Not happy_var_2
	)
happyReduction_18 _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_3  8 happyReduction_19
happyReduction_19 (HappyAbsSyn8  happy_var_3)
	_
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn8
		 (And happy_var_1 happy_var_3
	)
happyReduction_19 _ _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_3  8 happyReduction_20
happyReduction_20 (HappyAbsSyn8  happy_var_3)
	_
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn8
		 (Or  happy_var_1 happy_var_3
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_3  8 happyReduction_21
happyReduction_21 (HappyAbsSyn18  happy_var_3)
	(HappyAbsSyn10  happy_var_2)
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn8
		 (happy_var_2  happy_var_1 (Col happy_var_3)
	)
happyReduction_21 _ _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3  8 happyReduction_22
happyReduction_22 (HappyTerminal (TInt          happy_var_3))
	(HappyAbsSyn10  happy_var_2)
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn8
		 (happy_var_2  happy_var_1 (AI  happy_var_3)
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_3  8 happyReduction_23
happyReduction_23 (HappyAbsSyn9  happy_var_3)
	(HappyAbsSyn10  happy_var_2)
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn8
		 (happy_var_2  happy_var_1 (AS  happy_var_3)
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_3  9 happyReduction_24
happyReduction_24 _
	(HappyTerminal (TID           happy_var_2))
	_
	 =  HappyAbsSyn9
		 (happy_var_2
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_3  9 happyReduction_25
happyReduction_25 _
	(HappyTerminal (TID           happy_var_2))
	_
	 =  HappyAbsSyn9
		 (happy_var_2
	)
happyReduction_25 _ _ _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_1  10 happyReduction_26
happyReduction_26 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_1
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_1  11 happyReduction_27
happyReduction_27 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_1
	)
happyReduction_27 _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_1  11 happyReduction_28
happyReduction_28 _
	 =  HappyAbsSyn10
		 (Lt
	)

happyReduce_29 = happySpecReduce_1  11 happyReduction_29
happyReduction_29 _
	 =  HappyAbsSyn10
		 (Gt
	)

happyReduce_30 = happySpecReduce_1  11 happyReduction_30
happyReduction_30 _
	 =  HappyAbsSyn10
		 (LE
	)

happyReduce_31 = happySpecReduce_1  11 happyReduction_31
happyReduction_31 _
	 =  HappyAbsSyn10
		 (GE
	)

happyReduce_32 = happySpecReduce_1  12 happyReduction_32
happyReduction_32 _
	 =  HappyAbsSyn10
		 (Eq
	)

happyReduce_33 = happySpecReduce_1  12 happyReduction_33
happyReduction_33 _
	 =  HappyAbsSyn10
		 (NE
	)

happyReduce_34 = happySpecReduce_2  13 happyReduction_34
happyReduction_34 _
	_
	 =  HappyAbsSyn13
		 ([]
	)

happyReduce_35 = happySpecReduce_3  13 happyReduction_35
happyReduction_35 _
	(HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn13
		 (happy_var_2
	)
happyReduction_35 _ _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_1  14 happyReduction_36
happyReduction_36 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn13
		 ([happy_var_1]
	)
happyReduction_36 _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_3  14 happyReduction_37
happyReduction_37 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn13
		 (happy_var_1:happy_var_3
	)
happyReduction_37 _ _ _  = notHappyAtAll 

happyReduce_38 = happyReduce 5 15 happyReduction_38
happyReduction_38 (_ `HappyStk`
	(HappyTerminal (TID           happy_var_4)) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn18  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 ((happy_var_2,happy_var_4)
	) `HappyStk` happyRest

happyReduce_39 = happySpecReduce_2  16 happyReduction_39
happyReduction_39 _
	_
	 =  HappyAbsSyn16
		 ([]
	)

happyReduce_40 = happySpecReduce_3  16 happyReduction_40
happyReduction_40 _
	(HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn16
		 (happy_var_2
	)
happyReduction_40 _ _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_1  17 happyReduction_41
happyReduction_41 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn16
		 ([happy_var_1]
	)
happyReduction_41 _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_3  17 happyReduction_42
happyReduction_42 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn16
		 (happy_var_1:happy_var_3
	)
happyReduction_42 _ _ _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_3  18 happyReduction_43
happyReduction_43 (HappyTerminal (TID           happy_var_3))
	_
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn18
		 ((happy_var_1,happy_var_3)
	)
happyReduction_43 _ _ _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_1  18 happyReduction_44
happyReduction_44 (HappyTerminal (TID           happy_var_1))
	 =  HappyAbsSyn18
		 (([],happy_var_1)
	)
happyReduction_44 _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_1  19 happyReduction_45
happyReduction_45 (HappyTerminal (TID           happy_var_1))
	 =  HappyAbsSyn19
		 (happy_var_1
	)
happyReduction_45 _  = notHappyAtAll 

happyNewToken action sts stk
	= lexer(\tk -> 
	let cont i = action i i tk (HappyState action) sts stk in
	case tk of {
	TEOF -> action 51 51 tk (HappyState action) sts stk;
	TDot -> cont 20;
	TComa -> cont 21;
	TOpen -> cont 22;
	TClose -> cont 23;
	TOCor -> cont 24;
	TCCor -> cont 25;
	TEq -> cont 26;
	TNE -> cont 27;
	TLower -> cont 28;
	TGreater -> cont 29;
	TLowerOrEq -> cont 30;
	TGreaterOrEq -> cont 31;
	TAsignacion -> cont 32;
	TComSimple -> cont 33;
	TComDoble -> cont 34;
	TOr -> cont 35;
	TAnd -> cont 36;
	TNot -> cont 37;
	TID           happy_dollar_dollar -> cont 38;
	TInt          happy_dollar_dollar -> cont 39;
	TSeleccionar -> cont 40;
	TProyectar -> cont 41;
	TUnir -> cont 42;
	TRenombrar -> cont 43;
	TRestar -> cont 44;
	TCartesiano -> cont 45;
	TIntersecar -> cont 46;
	TNatural -> cont 47;
	TDividir -> cont 48;
	TRenombrarCol -> cont 49;
	TBorrar -> cont 50;
	_ -> happyError' tk
	})

happyError_ 51 tk = happyError' tk
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

parseOp = happySomeParser where
  happySomeParser = happyThen (happyParse action_0) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


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
