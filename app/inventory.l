
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
                  (catch NIL (mapc foldg (by '((I) (; I product)) group (events))) )
               (at (0 . 10000) (or (flush) (throw)) )
            (<row> 'nil
                  (<strong> ,"Total") - - - - - -
                  (<strong> (prin (money 1234)))
                  (<strong> ,"Date")
                  (<strong> (prin (datStr (date)))) ) ) ) ) ) ) )

(de foldg(Grp)
   (let Qty 0
      (inc 'Nr) 
      (mapc '((Rec) (with Rec (inc 'Qty (: quantity)))) Grp)
      (with (car Grp)
         (<row> (alternating)
            (<+> Nr)
            (<+> (: product category))
            (<+> (: product title))
            (<+> Qty) 
            (<+> (money (: sellprice)))
            (<+> (money (* (: sellprice) Qty)))
            (<+> (money (: buyprice)))
            (<+> (money (* (: buyprice) Qty)))
            (<+> (money (- (* (: sellprice) Qty) (* (: buyprice) Qty))))
            (<+> (: product supplier name)) ) ) ) )