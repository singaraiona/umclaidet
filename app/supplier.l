
(must "Suppliers" Supplier)

(menu, "Suppliers"
   (idForm, "Suppliers" '(choSup) 'name '+Supplier T '(may Delete)
      'nil
      (<hr>)
      (<tab>
         (,"Create"
            (<grid> 3
               ,"Name"   NIL (gui '(+E/R +Cue +TextField) '(name : home obj) ,"Name" 20) ) )
         (,"Import"
            (import::upfile import::suppliers) ) )
      (<hr>) ) )
