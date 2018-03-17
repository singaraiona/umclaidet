
(must "Inventory" Report)

(menu ,"Inventory"
   (<h3> NIL ,"Inventory")
   (form NIL
      (<grid> "-.-"         
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
                     (NIL   ,"Category")
                     (NIL   ,"Title")
                     (NIL   ,"Supplier")
                     (align ,"Buy price")
                     (align ,"Sell price")
                     (align ,"Quantity")
                     (align ,"Income") ) )
               (catch NIL
                  (mapc '((This)        
                     (<row> (alternating)
                           (<+> (: nr) This)
                           (<+> (datStr (: date)) This)
                           (<+> (: product brand) (: product))
                           (<+> (: product name) (: product))
                           (<+> (: product supplier name) (: product supplier))
                           (<+> (money (: price)) This)
                           (<+> (money (: price)) This)
                           (<+> (: quantity) This)
                           (<-> (+ (* (: price) (: quantity)) 1)) ) )
                     (mm) )            
            (at (0 . 10000) (or (flush) (throw)) )
            (<row> 'nil
                  (<strong> ,"Total") - - - - - - -
                  (<strong> (prin (money 1234))) ) ) ) ) ) ) )