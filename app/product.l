
(must "Products" Product)

(menu, "Products"
   (idForm, "Products" '(choProd) 'nr '+Product T '(may Delete) '((: nr) " -- " (: brand) " -- " (: name))
      (<grid> 4
         ,"Number" NIL (gui '(+E/R +NumField) '(nr : home obj) 10) NIL
         ,"Brand"  NIL (gui '(+E/R +Cue +TextField) '(brand : home obj), 30) NIL
         ,"Supplier" (choSup 0)
         (gui '(+E/R +Obj +TextField) '(supplier : home obj) '(name +Supplier) 30)
         (gui '(+View +TextField) '(: home obj sup) 30) )))
