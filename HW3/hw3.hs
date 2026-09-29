--isLeapYear n --This could be a oneliner
--    | (mod n 400 == 0) || (mod n 4 == 0) && (mod n 100/=0) = True
--    | otherwise = False

isLeapYear n
    | mod n 400 == 0  = True
    | mod n 100 == 0  = False 
    | mod n 4   == 0  = True 
    | otherwise       = False


addcomma :: String -> String
addcomma [] = []
addcomma [x] = [x]
addcomma (x:xs) = [x]  ++ "," ++ addcomma xs


findMax m [] = m
findMax m (x:xs) 
    | x>m = findMax x xs
    | otherwise = findMax m xs


delValue _ [] = []
delValue m (x:xs) 
    | m == x = delValue m xs
    | otherwise = x:delValue m xs


rmax xs = delValue (findMax (head xs) xs) xs 


ptriples n = [(x,y, z)| x<-[1..n], y <- [1..n], z <- [1..n], x^2 + y^2 == z^2]
