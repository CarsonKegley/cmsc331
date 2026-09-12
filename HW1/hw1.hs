-- CMSC 331 Section 01 Homework 01
-- Name (userid): Carson Kegley
-- Average of a and b
-- Compute square root of x using Newton's method
-- Use x/4 as first approximation of the square root
sqRoot x =
    if x < 0 then
        error "You can't take square root of a negative number!"
    else
        newton x (x/4)


-- Recursively compute square root of x
-- r is the current approximation
newton x r =
    -- Case 1: r is too small, recurse with larger r
    if x > r * r + 0.01 then
        newton x average
    -- Case 2: r is too large, recurse with smaller r
    else if x < r * r - 0.01 then
        newton x average
    -- Case 3: r is close enough
    else
        r
    where average = avg r (x/r)

avg a b =  (a + b) / 2 
main = do
    print . sqRoot 19 . putStr "Square root of 19 = "
    --(print . sqRoot) 19
