showWT num  
    | p == 1= (show p) ++ " pound " ++ (show oz) ++ " ounces"
    | oz  == 1= (show p) ++ " pounds " ++ (show oz) ++ " ounce"
    | otherwise = (show p) ++ " pounds " ++ (show oz) ++ " ounces"
    where
        p  = div num 16
        oz = mod num 16
