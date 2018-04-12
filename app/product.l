
(must "Product" Product)

(menu, "Products"
   (idForm, "Product" '(choProd) 'nr '+Product T '(may Delete)
      '((: category name) " -- " (: title))
      (<hr>)
         (<grid> 3
            ,"Code" NIL (gui 'nr '(+E/R +Able +NumField) '(nr : home obj) NIL 10)
            ,"Category" (choCat 0)
               (gui 'category '(+Set +E/R +Obj +TextField)
                  '((V)
                     (with (: home obj)
                        (ifn (= V (: category))
                           (put!> This 'nr (utils::prodkey V)) ) )
                     V )
                  '(category : home obj) '(name +Category) 10)
            ,"Title"   NIL (gui '(+E/R +TextField) '(title : home obj) 10)
            ,"Supplier" (choSup 0)
               (gui '(+E/R +Obj +TextField) '(supplier : home obj) '(name +Supplier) 10) )
        (<hr>)
        (newButton T Dst '(+Product)
            'category  (or (val> (: home category)) (car (collect 'nr '+Category)))
            'nr (utils::prodkey (or (val> (: home category)) (car (collect 'nr '+Category)))) ) ) )
