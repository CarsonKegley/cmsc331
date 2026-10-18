// global variables

global &dollar$
global &scalar
global &flag?

@foo$ (m , n) 
   // local variables
   x$ y$ z$ 
begin
   x$ := 2 * ( y$ - z$ ) ;

   for i := 1 ; i <= n ; i := i + 1 do
      x$ := x$ + i*x$ ;
   end

   &flag? := true ;
   while &flag? do
      if x$ <= y$ + z$ do
         &flag? := false ;
      end
      x$ := 0.5 * x$ ;
   end

   return x$ ;
end
