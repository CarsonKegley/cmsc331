module Token where

import LangTypes

data Token 

   -- literal constants
   = TkBool   Bool       -- boolean true or false
   | TkDllr   Int        -- dollar literal     
   | TkSclr   Int        -- scalar literal     
   | TkStrg   String     -- literal string

   -- identifiers
   --    global variables start with &
   --    booleans end with ?
   --    dollars end with $
   --    scalars don't have a suffix
   --    functions start with @
   --    procedures start with _

   | TkId IdKind EType String

   -- more
   | TkKW    String     -- keyword
   | TkOp    String     -- unary or binary operator
   | TkComp  String     -- comparison operator
   | TkPunc  String     -- punctuation 

   -- special cases
   | TkError String     -- error found with message
   | TkEOF              -- end of file

   deriving (Show, Eq, Read)

