
(must "Products" Product)

(menu, "Products"
   (idForm, "Products" '(choProd) 'category '+Product T '(may Delete)
      'nil
      (<hr>)
         (<grid> 3
            ,"Category"  NIL (gui '(+E/R +TextField) '(category : home obj))
            ,"Title"   NIL (gui '(+E/R +TextField) '(title : home obj))
            ,"Supplier" (choSup 0)
            (gui '(+E/R +Obj +TextField) '(supplier : home obj) '(name +Supplier)) )
        (<hr>) ) )
