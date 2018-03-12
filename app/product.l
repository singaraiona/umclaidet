
(must "Product" Product)

(menu, "Product"
   (idForm, "Product" '(choProd) 'number '+Product T '(may Delete) '((: number) " -- " (: brand) " -- " (: name))
      (<grid> 4
         ,"Number" NIL (gui '(+E/R +NumField) '(number : home obj) 10) NIL
         ,"Brand"  NIL (gui '(+E/R +Cue +TextField) '(brand : home obj), 30) NIL
         ,"Supplier" (choSup 0)
         (gui '(+E/R +Obj +TextField) '(supplier : home obj) '(nm +Supplier) 30)
         (gui '(+View +TextField) '(: home obj sup ort) 30) )))
