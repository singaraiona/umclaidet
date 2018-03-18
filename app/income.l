
(must "Income" Income)

(menu, "Income"
   (idForm ,"Income" '(choInc) 'nr '+Income T '(may Delete)
      '(" №" (: nr) " (" (datStr (: date)) ")")
      (<hr>)
      (<grid> 3
         ,"Number" NIL        (gui '(+E/R +NumField) '(nr : home obj) 10)
         ,"Date" NIL          (gui '(+E/R +DateField) '(date : home obj) 10)
         ,"Title" (choProd 0) (gui '(+Set +E/R +Obj +TextField) inc::upfields '(product : home obj) '(title +Product) 10)
         ,"Quantity" NIL      (gui '(+E/R +NumField) '(quantity : home obj) 10)
         ,"Sell price" NIL    (gui '(+E/R +FixField) '(sellprice : home obj) 2 10)
         ,"Buy price" NIL     (gui '(+E/R +FixField) '(buyprice : home obj) 2 10) )
      (<hr>) ) )

# Update rest fields when Product has been changed
(de inc::upfields(V)
  (with (: home obj)
       (ifn (= V (: product)) 
          (let I (lastinc V)
             (put!> This 'quantity  (; I quantity))
             (put!> This 'sellprice (; I sellprice))
             (put!> This 'buyprice  (; I buyprice)) )
          ) ) 
  V)

# Find the last Income record in db mathes `Prod
(de lastinc(Prod)
      (last
         (pilog
            (quote
               @Prod Prod
               (select (@Income)
                  ((product +Income @Prod))
                    (same @Prod @Income product) ) )
         @Income ) ) )
          