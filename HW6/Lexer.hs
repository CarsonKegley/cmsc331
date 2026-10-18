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


   -- Look for punctuation and delimiters

   |  (_,_,after,[match]) <- ( str =~ "\\A([:;])" :: MatchType4 )
   =  TkPunc match : lexer after


   -- Look for string literals

   |  (_,_,after,[match]) <- ( str =~ "\\A\"([^\"]*)\"" :: MatchType4 ) 
   =  TkStrg match : lexer after


   -- Look for integer numbers. \s is white space in PCRE.

   |  (_,_,after,[match]) <- ( str =~ "\\A([0-9]+)\\s" :: MatchType4 )
   =  TkSclr ( read match :: Int ) : lexer after


   -- Everything else is an identifier. \S is non-whitespace in PCRE.

   |  (_,_,after,[match]) <- ( str =~ "\\A(\\S+)" :: MatchType4 ) 
   =  TkId LocalVarId ESclr match : lexer after


   -- Deal with errors
   |  otherwise
   =  TkError "all guards failed" : lexer (drop 1 str)

