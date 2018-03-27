
(must "Supplier" Supplier)

(menu, "Suppliers"
   (idForm, "Suppliers" '(choSup) 'nr '+Supplier T '(may Delete)
      '((: name))
      (<hr>)
         (<grid> 3
         ,"Number" NIL (gui '(+E/R +NumField) '(nr : home obj) 20)
         ,"Name"   NIL (gui '(+E/R +Cue +TextField) '(name : home obj) ,"Name" 20) )
      (<hr>)
      (newButton T Dst '(+Supplier)
         '(nr genKey 'nr '+Supplier) ) ) )
