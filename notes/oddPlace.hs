oddPlace [] = []
oddPlace (_:x:xs) = [x] ++ oddPlace xs
oddPlace x = []


