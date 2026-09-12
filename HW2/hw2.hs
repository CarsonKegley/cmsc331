secondLast x  
    | n>2 = last (take (n-1) x)
    | otherwise = error "list have at least two items"
    where n = length x

middleHalf xs = 
    take (div n 2) (drop (div n 4) xs)
    where n = length xs
    
piggy1 xs = 
    if n <1 then
        False
    else if n > 1 then
        elem 'o' (take 2 xs)
    else if n ==1 then
        head xs == 'o'
    else False

    where n = length xs

piggy2 xs
    | n>1  =  elem 'o' (take 2 xs)
    | n==1 =  'o' == head xs  
    | otherwise = False

    where n = length xs

piggy3 (f:s:_) = f == 'o' || s == 'o'
piggy3 (f:_)   = f == 'o'  
piggy3  _      = False
