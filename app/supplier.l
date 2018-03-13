
(must "Suppliers" Supplier)

(menu, "Suppliers"
   (idForm, "Suppliers" '(choSup) 'nr '+Supplier T '(may Delete)
      '((: nr))
      (<hr>)
      (<grid> 3
            ,"Number" NIL (gui '(+E/R +NumField) '(nr : home obj) 10)
            ,"Name"   NIL (gui '(+E/R +Cue +TextField) '(name : home obj) ,"Name" 20) )
      (<hr>) ) )