
(must "Supplier" Supplier)

(menu ,"Supplier"
   (idForm ,"Supplier" '(choSup) 'number '+Supplier T '(may Delete)
      '((: number) " -- " (: name))
      (<hr>)
      (<tab>
         (,"Name"
            (<grid> 2
               ,"Number" NIL (gui '(+E/R +NumField) '(number : home obj) 10)
               ,"Name"   NIL (gui '(+E/R +Cue +TextField) '(number : home obj) ,"Name" 40) )))
      (<hr>)
      (<spread> NIL (editButton T)) ) )

# vi:et:ts=3:sw=3
