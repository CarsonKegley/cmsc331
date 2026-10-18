worth str
    | (x:y:xs) <- str, x =='a',y=='b', n >= 5, n<=9  = 13
    | (x:y:xs) <- str, x=='x', (y=='y' || y=='z') = 5 + worth xs
    | x  <- str, x == "q" = 9
    | otherwise = 0
    where n = length str

