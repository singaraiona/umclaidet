
(must "Inventory" Report)

(menu ,"Inventory"
   (<h3> NIL ,"Inventory")
   (form NIL
      (<grid> "-.-"
         ,"Number" NIL
         (prog
            (gui 'nrfrom '(+Var +NumField) '*InvNrFrom 10)
            (prin " - ")
            (gui 'nrtill '(+Var +NumField) '*InvNrTill 10) )
         ,"Date" NIL
         (prog
            (gui 'datfrom '(+Var +DateField) '*InvDtFrom 10)
            (prin " - ")
            (gui 'dattill '(+Var +DateField) '*InvDtTill 10) ) )
      (--)
      (resetButton '(nrfrom nrtill datfrom dattill))
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
                        (select (@@)
                           ((nr +Admission @RngNr) (date +Admission @RngDt))
                           (range @RngNr @@ nr)
                           (range @RngDt @@ date) ) )
                     (with @@
                        (<row> (alternating)
                           (<+> (: nr) This)
                           (<+> (date (: date)) This)
                           (<+> (: product brand) (: product))
                           (<+> (: product name) (: product))
                           (<+> (: product supplier name) (: product supplier))
                           (<+> (money (: price)) This)
                           (<+> (money (: price)) This)
                           (<+> (: quantity) This)
                           (<-> (+ (* (: price) (: quantity)) 1)) ) )
            (at (0 . 10000) (or (flush) (throw))) ) ) ) ) ) ) )
