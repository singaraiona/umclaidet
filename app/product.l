
(must "Products" Product)

(menu, "Products"
   (idForm, "Products" '(choProd) 'nr '+Product T '(may Delete) '((: nr) " -- " (: brand) " -- " (: name))
      (<grid> 6
         ,"Number" NIL (gui '(+E/R +NumField) '(nr : home obj) 10)
         ,"Brand"  NIL (gui '(+E/R +Cue +TextField) '(brand : home obj) ,"Brand" 40)
         ,"Name"   NIL (gui '(+E/R +Cue +TextField) '(name : home obj)  ,"Name" 40)
         ,"Supplier" (choSup 0)
         (gui '(+E/R +Obj +TextField) '(supplier : home obj) '(name +Supplier) 30) )))
