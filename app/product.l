
(must "Products" Product)

(menu, "Products"
   (idForm, "Products" '(choProd) 'category '+Product T '(may Delete)
        'nil
        (<hr>)
        (<tab>
           (,"Create"
              (<grid> 3
                 ,"Category"  NIL (gui '(+E/R +Cue +TextField) '(category : home obj) ,"Category" 20)
                 ,"Title"   NIL (gui '(+E/R +Cue +TextField) '(title : home obj)  ,"Title" 20)
                 ,"Supplier" (choSup 0)
                   (gui '(+E/R +Obj +TextField) '(supplier : home obj) '(name +Supplier) 20) ) )
           (,"Import"
              (import::upfile import::products) ) )
        (<hr>) ) )
