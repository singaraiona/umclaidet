
(must "Expense" Expense)

(menu, "Expense"
   (idForm ,"Expense" '(choExp) 'nr '+Expense T '(may Delete)
      '((: nr))
      (<hr>)
      (<grid> 6
         ,"Number" NIL    (gui '(+E/R +NumField) '(nr : home obj) 10)
         ,"Date" NIL      (gui '(+E/R +Cue +DateField) '(date : home obj) ,"Date" 10)
         ,"Product name"  (choProd 0)
            (gui '(+E/R +Obj +Cue +TextField) '(product : home obj) '(name +Product) ,"Product name" 10)
         ,"Buy price" NIL (gui '(+E/R +FixField) '(price : home obj) 2 10)
         ,"Quantity" NIL  (gui '(+E/R +NumField) '(quantity : home obj) 10) )
      (<hr>)) )

