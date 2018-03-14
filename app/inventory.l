
(must "Inventory" Report)

(menu ,"Inventory"
   (<h3> NIL ,"Inventory")
   (form NIL
      (<grid> "-.-"
         ,"Number" NIL
         (prog
            (gui '(+Var +NumField) '*InvNrFrom 10)
            (prin " - ")
            (gui '(+Var +NumField) '*InvNrTill 10) )
         ,"Date" NIL
         (prog
            (gui '(+Var +DateField) '*InvDtFrom 10)
            (prin " - ")
            (gui '(+Var +DateField) '*InvDtTill 10) ) )
      (--)
      (gui '(+ShowButton) NIL
         '(csv ,"Inventory"
            (<table> 'chart NIL
               (<!>
                  (quote
                     (align ,"Number")
                     (NIL   ,"Date")
                     (NIL   ,"Brand")
                     (NIL   ,"Name")
                     (NIL   ,"Supplier")
                     (align ,"Buy price")
                     (align ,"Sell price")
                     (align ,"Quantity")
                     (align ,"Income") ) )
               (catch NIL
                  (pilog
                     (quote
                        @RngNr (cons *InvNrFrom (or *InvNrTill T))
                        @RngDt (cons *InvDtFrom (or *InvDtTill T))
                        (select (@Admission)
                           ((nr +Admission @RngNr))
                           (range @RngNr @ nr)
                           (range @RngDt @ date) ) )
                     (with @Admission
                        (<row> (alternating)
                           (<+> (: nr) This)
                           (<+> (date (: date)) This)
                           (<+> (: product brand) (: product))
                           (<+> (: product name) (: product))
                           (<+> (: supplier name) (: product))
                           (<+> (money (: price)) This)
                           (<+> (money (: price)) This)
                           (<+> (: quantity) This)
                           (<+> (+ (* (: price) (: quantity)) 1)) ) )
(at (0 . 10000) (or (flush) (throw))) ) ) ) ) ) ) )