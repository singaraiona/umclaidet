
(must "Admissions" Admission)

(menu, "Admissions"
   (idForm ,"Admission" '(choAdm) 'nr '+Admission T '(may Delete)
      '((: nr))
      (<hr>)
      (<grid> 3
         ,"Number" NIL    (gui '(+E/R +NumField) '(nr : home obj) 10)
         ,"Date" NIL      (gui '(+E/R +Cue +DateField) '(date : home obj) ,"Date" 20)
         ,"Product name"  (choProd 0)
            (gui '(+E/R +Obj +Cue +TextField) '(product : home obj) '(name +Product) ,"Product name" 20)
         ,"Buy price" NIL (gui '(+E/R +Cue +FixField) '(price : home obj) ,"Buy price" 2 20)
         ,"Quantity" NIL  (gui '(+E/R +Cue +NumField) '(quantity : home obj) ,"Quantity" 20) )
      (<hr>)) )

