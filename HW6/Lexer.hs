module Lexer where
-- Carson Kegley (ckegley1)

import Text.Regex.PCRE
import LangTypes
import Token

-- type synonym to get ~= to give us an array of matches captured by ( )

type MatchType1 = Bool 
type MatchType2 = String
type MatchType3 = (String,String,String)
type MatchType4 = (String,String,String,[String])


-- str usually has linefeeds and carriage returns (!!)
-- We have to use \A and \Z instead of ^ and $ in the regex patterns
-- Also, the \ in regex patterns must be escaped in Haskell strings



lexer :: String -> [ Token ]

lexer str 

   -- base case that shouldn't happen
   |  "" <- str
   =  [TkError "end of string"]


   -- base case reached $$
   |  (_,_,after,[_]) <- ( str =~ "\\A(\\$\\$)" :: MatchType4 )
   =  [TkEOF]


   -- remove leading whitespace. \s is white space in PCRE

   |  (_,_,after,[_]) <- ( str =~ "\\A(\\s+)" :: MatchType4 )
   =  lexer after

   -- Removing single line comments 
   |  (_,_,after,[_]) <- ( str =~ "\\A(//.*\\n)" :: MatchType4 )
   =  lexer after

   -- Removing multi-line comments 
   |  (_,_,after,[_]) <- ( str =~ "\\A(\\{[^\\}]*\\})" :: MatchType4 )
   =  lexer after

   -- Add multi character operators
   |  (_,_,after,[match]) <- ( str =~ "\\A(:=|&&|\\|\\|)" :: MatchType4 )
   =  TkOp match : lexer after

   -- Add multi character comparators
   |  (_,_,after,[match]) <- ( str =~ "\\A(<=|==|!=|>=)" :: MatchType4 )
   =  TkComp match : lexer after

   -- Looking for keywords
   |  (_,_,after,[match]) <- ( str =~ "\\A(begin|do|else|elsif|end|extern|for|global|if|loop|print|println|return|then|until|while)\\b" :: MatchType4 )
   =  TkKW match : lexer after

   -- Looking for Bool Keyword
   |  (_,_,after,[match]) <- ( str =~ "\\A(true|false)" :: MatchType4 )
   =  TkBool (parseBool match) : lexer after

   -- Look for punctuation and delimiters

   |  (_,_,after,[match]) <- ( str =~ "\\A([(),;])" :: MatchType4 )
   =  TkPunc match : lexer after

   |  (_,_,after,[match]) <- ( str =~ "\\A([*/+\\-~])" :: MatchType4 )
   =  TkOp match : lexer after

   -- Single Char Comparators
   |  (_,_,after,[match]) <- ( str =~ "\\A([<>])" :: MatchType4 )
   =  TkComp match : lexer after

   -- Look for string literals

   |  (_,_,after,[match]) <- ( str =~ "\\A\"([^\"]*)\"" :: MatchType4 ) 
   =  TkStrg match : lexer after



   -- Dollars
   -- Matching decimal dollars
   |  (_,_,after,[match]) <- ( str =~ "\\A\\$([0-9]+\\.[0-9]+)" :: MatchType4 )
   =  TkDllr  (parseDollar match) : lexer after
   -- Matching dollars with commas
   |  (_,_,after,[match]) <- ( str =~ "\\A\\$([0-9]{1,3}(?:,[0-9]{3})*(?:.[0-9]+)*)" :: MatchType4 )
   =  TkDllr (parseDollar (stripComma match)) : lexer after



   -- Matching integer dollars
   |  (_,_,after,[match]) <- ( str =~ "\\A\\$([0-9]+)" :: MatchType4 )
   =  TkDllr  (parseDollar match) : lexer after

   
   -- Scalars
   -- Matching Decimals
   |  (_,_,after,[match]) <- ( str =~ "\\A([0-9]+\\.[0-9]+)" :: MatchType4 )
   =  TkSclr  (parseScalar match) : lexer after

   -- Matching non decimal
   |  (_,_,after,[match]) <- ( str =~ "\\A([0-9]+)" :: MatchType4 )
   =  TkSclr (parseScalar match)  : lexer after

   -- Identifier Stack need a lot of guards guards for all of the cases

   -- Dollar Ids local and global
   |  (_,_,after,[match]) <- ( str =~ "\\A([a-zA-Z]+[a-zA-Z0-9]*)\\$" :: MatchType4 ) 
   =  TkId LocalVarId EDllr match : lexer after

   |  (_,_,after,[match]) <- ( str =~ "\\A\\&([a-zA-Z]+[a-zA-Z0-9]*)\\$" :: MatchType4 ) 
   =  TkId GlobalVarId EDllr match : lexer after

   |  (_,_,after,[match]) <- ( str =~ "\\A\\@([a-zA-Z]+[a-zA-Z0-9]*)\\$" :: MatchType4 ) 
   =  TkId FunPrcId EDllr match : lexer after

   -- Bool Ids local and global
   |  (_,_,after,[match]) <- ( str =~ "\\A([a-zA-Z]+[a-zA-Z0-9]*)\\?" :: MatchType4 ) 
   =  TkId LocalVarId EBool match : lexer after

   |  (_,_,after,[match]) <- ( str =~ "\\A\\&([a-zA-Z]+[a-zA-Z0-9]*)\\?" :: MatchType4 ) 
   =  TkId GlobalVarId EBool match : lexer after

   |  (_,_,after,[match]) <- ( str =~ "\\A\\@([a-zA-Z]+[a-zA-Z0-9]*)\\?" :: MatchType4 ) 
   =  TkId FunPrcId EBool match : lexer after


   -- Scalar Ids local and global
   |  (_,_,after,[match]) <- ( str =~ "\\A([a-zA-Z]+[a-zA-Z0-9]*)" :: MatchType4 ) 
   =  TkId LocalVarId ESclr match : lexer after

   |  (_,_,after,[match]) <- ( str =~ "\\A\\&([a-zA-Z]+[a-zA-Z0-9]*)" :: MatchType4 ) 
   =  TkId GlobalVarId ESclr match : lexer after

   |  (_,_,after,[match]) <- ( str =~ "\\A\\@([a-zA-Z]+[a-zA-Z0-9]*)" :: MatchType4 ) 
   =  TkId FunPrcId ESclr match : lexer after

   -- Error Statt
   |  (_,_,after,[match]) <- ( str =~ "\\A_([a-zA-Z]+[a-zA-Z0-9]*)" :: MatchType4 ) 
   =  TkId FunPrcId NADA match : lexer after

   -- Deal with errors
   |  otherwise
   =  TkError "all guards failed" : lexer (drop 1 str)

parseScalar str  = truncate (10000 * (read str :: Double)) 
parseDollar str  = truncate (100 * (read str :: Double)) 

stripComma str 
   | [] <- str = []
   | [x] <- str= [x]
   | (x:xs) <- str, x == ',' = stripComma xs
   | (x:xs) <- str = x:stripComma xs


parseBool str 
   | str == "true" = True
   | str == "false" = False
 
