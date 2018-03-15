
(must "Products" Product)

(menu, "Products"
   (idForm, "Products" '(choProd) 'nr '+Product T '(may Delete)
        '((: nr))
        (<hr>)
        (<grid> 3
            ,"Number" NIL (gui '(+E/R +NumField) '(nr : home obj) 10)
            ,"Category"  NIL (gui '(+E/R +Cue +TextField) '(category : home obj) ,"Category" 20)
            ,"Title"   NIL (gui '(+E/R +Cue +TextField) '(title : home obj)  ,"Title" 20)
            ,"Supplier" (choSup 0)
            (gui '(+E/R +Obj +TextField) '(supplier : home obj) '(name +Supplier) 20) )
        (<hr>) ) )
