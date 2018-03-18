
(must "Inventory" Report)

(menu ,"Inventory"
   (<h3> NIL ,"Inventory")
   (form NIL
      (<grid> "-.-"         
         ,"Date" NIL
         (prog
            (gui 'datfrom '(+Var +DateField) '*InvFrom 10)
            (prin " - ")
            (gui 'dattill '(+Var +DateField) '*InvTill 10) ) )
      (--)      
      (gui '(+ShowButton) NIL
         '(csv ,"Inventory"
            (let (TotalQty 0
                  TotalSellQty 0
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
                        (catch NIL (mapc grp::fold (by '((I) (; I product)) group (evts::find (cons *InvFrom (or *InvTill T))))) )
                  (<row> 'nil
                     (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL)
                     (<+> ,"Sold:")
                     (<-> TotalSellQty) )
                  (<row> 'nil
                     (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL)
                     (<+> ,"Balance:")
                     (<-> (- TotalQty TotalSellQty)) )                  
                  (<row> 'nil
                     (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL)
                     (<+> ,"Income:")
                     (<-> (money (* TotalSellQty TotalCharge))) )
                  (<row> 'nil
                     (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL)
                     (<+> ,"Date:")
                     (<-> (datStr (date))) )      
                     (at (0 . 10000) (or (flush) (throw))) ) ) ) ) )
      (resetButton '(datfrom dattill)) ) )

(de grp::fold(Grp)
   (let (Tqty 0
         Sqty 0)
      (inc 'Nr) 
      (mapc evt::proc Grp)
      (with (car Grp)
         (<row> (alternating)
            (<+> Nr)
            (<+> (: product category))
            (<+> (: product title))
            (<+> (- Tqty Sqty)) 
            (<+> (money (: sellprice)))
            (<+> (money (* (: sellprice) Sqty)))
            (<+> (money (: buyprice)))
            (<+> (money (* (: buyprice) Sqty)))
            (<+> (money (- (* (: sellprice) Sqty) (* (: buyprice) Sqty))))
            (<-> (: product supplier name)) ) 
         (inc 'TotalCharge (- (* (: sellprice) Sqty) (* (: buyprice) Sqty))) ) 
      (inc 'TotalQty Tqty) 
      (inc 'TotalSellQty Sqty) ) )

(de evt::proc(Rec)
   (with Rec
      (if (= (: tp) 1) 
          (inc 'Tqty (: quantity)) 
          (inc 'Sqty (: quantity))) ) )

(de evts::find(Rng)
   (solve
      (quote
         @Rng Rng
            (select (@Event)
               ((date +Event @Rng))
                  (range @Rng @Event date) ) )
      @Event) )
