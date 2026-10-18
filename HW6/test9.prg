
global &bracket10$
global &bracket12$
global &bracket22$
global &bracket24$
global &bracket32$
global &bracket35$


_main ( )

   // local variables
   income$ 
   tax$

begin

   &bracket10$ :=  $11,925 ;
   &bracket12$ :=  $48,475 ;
   &bracket22$ := $103,350 ;
   &bracket24$ := $197,300 ;
   &bracket32$ := $250,525 ;
   &bracket35$ := $626,350 ;

   print "Enter taxable income: " ;
   income$ := @read() ;
   print "Your federal tax as a single filer is: " ;
   tax$ := @singleFiler( income$ ) ;
   println tax$ ;

end



@singleFiler ( amount$ ) 

   // local variables
   tax$       // tax due
   mrate      // marginal tax rate
   margin$    // amount taxed at marginal rate

begin
   if amount$ <= &bracket10$ then

      mrate := 0.10 ;
      margin$ := amount$ ;   // everything taxed @ 10%
      tax$ := margin$ * mrate + $0 ;

   elsif amount$ <= &bracket12$ then

      mrate := 0.12 ;
      margin$ := amount$ - &bracket10$ ;
      tax$ := margin$ * mrate + $1,192.50 ;

   elsif amount$ <= &bracket22$ then 

      mrate := 0.22 ;
      margin$ := amount$ - &bracket12$ ;
      tax$ := margin$ * mrate + $5,578.50 ;
      
   elsif amount$ <= &bracket24$ then 

      mrate := 0.24 ;
      margin$ := amount$ - &bracket22$ ;
      tax$ := margin$ * mrate + $17,651.00 ;
      
   elsif amount$ <= &bracket32$ then

      mrate := 0.32 ;
      margin$ := amount$ - &bracket24$ ;
      tax$ := margin$ * mrate + $40,199.00 ;
      
   elsif amount$ <= &bracket35$ then

      mrate := 0.35 ;
      margin$ := amount$ - &bracket32$ ;
      tax$ := margin$ * mrate + $57,231.00 ;
      
   else 

      mrate := 0.37 ;
      margin$ := amount$ - &bracket35$ ;
      tax$ := margin$ * mrate + $188,769.75 ;
      
   end

   return tax$ ;

end


