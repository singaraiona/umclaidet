
(must "Category" Category)

(menu, "Categories"
   (idForm, "Category" '(choCat) 'nr '+Category T '(may Delete)
      '((: name))
      (<hr>)
      (<grid> 3
       ,"Number" NIL (gui '(+E/R +Able +NumField) '(nr : home obj) NIL 20)
       ,"Name"   NIL (gui '(+E/R +Cue +TextField) '(name : home obj) ,"Name" 20))
      (<hr>)
      (newButton T Dst '(+Category)
         'nr (utils::catkey))))
