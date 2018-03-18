
(must "Expense" Expense)

(menu, "Expense"
   (idForm ,"Expense" '(choExp) 'nr '+Expense T '(may Delete)
      '(" №" (: nr) " (" (datStr (: date)) ")")
      (<hr>)
      (<grid> 3
         ,"Number" NIL        (gui '(+E/R +NumField) '(nr : home obj) 10)
         ,"Date" NIL          (gui '(+E/R +DateField) '(date : home obj) 10)
         ,"Title" (choProd 0) (gui '(+Set +E/R +Obj +TextField) exp::upfields '(product : home obj) '(title +Product) 10)
         ,"Quantity" NIL      (gui '(+E/R +NumField) '(quantity : home obj) 10)
         ,"Sell price" NIL    (gui '(+E/R +FixField) '(sellprice : home obj) 2 10)
         ,"Buy price" NIL     (gui '(+E/R +FixField) '(buyprice : home obj) 2 10) )
      (<hr>) ) )

# Update rest fields when Product has been changed
(de exp::upfields(V)
  (with (: home obj)
       (ifn (= V (: product)) 
          (let I (lastexp V)
             (put!> This 'quantity  (; I quantity))
             (put!> This 'sellprice (; I sellprice))
             (put!> This 'buyprice  (; I buyprice)) )
          ) ) 
  V)

# Find the last Expense record in db mathes `Prod
(de lastexp(Prod)
      (last
         (pilog
            (quote
               @Prod Prod
               (select (@Expense)
                  ((product +Expense @Prod))
                    (same @Prod @Expense product) ) )
         @Expense ) ) )