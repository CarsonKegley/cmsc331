module LangTypes where

-- expression types for dollar, scalar and boolean 
-- NADA means no type

data EType = NADA | EDllr | ESclr | EBool
             deriving (Show, Read, Eq)


-- different kinds of local variable, global variable or function name
-- RIEN means error

data IdKind = RIEN 
            | LocalVarId 
            | GlobalVarId 
            | FunPrcId         -- function or procedure
            deriving (Show, Read, Eq)

