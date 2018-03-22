
(must "Suppliers" Supplier)

(menu, "Suppliers"
   (idForm, "Suppliers" '(choSup) NIL NIL T '(may Delete)
      'nil
      (<hr>)
         (<grid> 3
         ,"Name"   NIL (gui '(+E/R +Cue +TextField) '(name : home obj) ,"Name" 20) )
      (<hr>) ) )
