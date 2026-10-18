import Text.Read
import Data.Char
import Lexer


-- Main program does the I/O
--
main = do

   input <- getContents
   putStrLn $ show (lexer (input ++ "\n$$") )
