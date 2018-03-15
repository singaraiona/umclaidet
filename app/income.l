
(must "Income" Income)

(menu, "Income"
   (idForm ,"Income" '(choInc) 'nr '+Income T '(may Delete)
      '(" №" (: nr) " (" (datStr (: date)) ")")
      (<hr>)
      (<grid> 3
         ,"Number" NIL        (gui '(+E/R +NumField) '(nr : home obj) 10)
         ,"Date" NIL          (gui '(+E/R +DateField) '(date : home obj) 10)
         ,"Title" (choProd 0) (gui '(+E/R +Obj +Cue +TextField) '(product : home obj) '(title +Product) ,"Title" 10)
         ,"Quantity" NIL      (gui '(+E/R +NumField) '(quantity : home obj) 10)
         ,"Sell price" NIL    (gui '(+E/R +FixField) '(sellprice : home obj) 2 10)
         ,"Buy price" NIL     (gui '(+E/R +FixField) '(buyprice : home obj) 2 10) )
      (<hr>) ) )
