
(must "Invoice" Report)

(menu ,"Invoice"
   (<h3> NIL ,"Invoice")
   (form NIL
      (<grid> "-.-"
         ,"Date" NIL
         (prog
            (gui 'datfrom '(+Init +Var +DateField) (apply min (utils::dates)) '*InvFrom 10)
            (prin " - ")
            (gui 'dattill '(+Init +Var +DateField) (apply max (utils::dates)) '*InvTill 10) ) )
      (--)
      (gui '(+ShowButton) NIL
         '(csv ,"Remains"
            (let (TotalSellSum 0
                  TotalBuySum 0
                  TotalCharge 0)
               (<table> 'chart NIL
                  (<!>
                     (quote
                        (align ,"#")
                        (NIL   ,"Category")
                        (NIL   ,"Title")
                        (align ,"Quantity")
                        (align ,"Sell price")
                        (align ,"Sell sum")
                        (align ,"Buy price")
                        (align ,"Buy sum")
                        (align ,"Charge")
                        (NIL   ,"Supplier") ) )
                     (let Nr 0
                        (catch NIL (mapc rem::fold (by '((I) (; I product)) group (rem::find (cons *InvFrom (or *InvTill T))))) )
                  (<row> 'nil
                     (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL)
                     (<+> ,"Total:")
                     (<+> (money TotalSellSum))
                     (<+> NIL)
                     (<+> (money TotalBuySum))
                     (<+> (money TotalCharge))
                     (<-> NIL) )
                  (<row> 'nil
                     (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL)
                     (<+> ,"Date from")
                     (<+> (datStr *InvFrom))
                     (<+> ,"Date till")
                     (<-> (datStr *InvTill)) )
                  (at (0 . 10000) (or (flush) (throw))) ) ) ) ) )
      (resetButton '(datfrom dattill)) ) )