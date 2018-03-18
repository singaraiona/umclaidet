
(must "Сapitalization" Capitalization)

(menu ,"Capitalization"
   (<h3> NIL ,"Capitalization")
   (form NIL
      (<grid> "-.-"         
         ,"Date" NIL
         (prog
            (gui 'datfrom '(+Var +DateField) '*InvFrom 10)
            (prin " - ")
            (gui 'dattill '(+Var +DateField) '*InvTill 10) ) )
      (--)      
      (gui '(+ShowButton) NIL
         '(csv ,"Capitalization"
            (let (TotalQty 0
                  TotalSellQty 0
                  TotalSellPrice 0                  
                  TotalBuyQty 0
                  TotalBuyPrice 0                  
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
                     (<+> ,"Selling:")
                     (<-> (money TotalSellPrice)) )
                  (<row> 'nil
                     (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL)
                     (<+> ,"Buying:")
                     (<-> (money TotalBuyPrice)) )
                  (<row> 'nil
                     (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL)
                     (<+> ,"Income:")
                     (<-> (money TotalCharge)) )
                  (<row> 'nil
                     (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL)
                     (<+> ,"Date:")
                     (<-> (datStr (date))) )      
                     (at (0 . 10000) (or (flush) (throw))) ) ) ) ) )
      (resetButton '(datfrom dattill)) ) )

(de grp::fold(Grp)
   (let (Bqty 0
         Bprc 0 
         Sqty 0
         Sprc 0)
      (inc 'Nr) 
      (mapc evt::proc Grp)
      (with (car Grp)
         (<row> (alternating)
            (<+> Nr)
            (<+> (: product category))
            (<+> (: product title))
            (<+> (- Bqty Sqty)) 
            (<+> (money (: sellprice)))
            (<+> (money (* (: sellprice) (- Bqty Sqty))))
            (<+> (money (: buyprice)))
            (<+> (money (* (: buyprice) (- Bqty Sqty))))
            (<+> (money (- (* (: sellprice) (- Bqty Sqty)) (* (: buyprice) (- Bqty Sqty)))))
            (<-> (: product supplier name)) ) 
         (inc 'TotalCharge (- (* (: sellprice) Sqty) (* (: buyprice) Sqty))) )
      (inc 'TotalBuyQty Bqty) 
      (inc 'TotalBuyPrice Bprc) 
      (inc 'TotalSellQty Sqty) 
      (inc 'TotalSellPrice Sprc) ) )

(de evt::proc(Rec)
   (with Rec
      (if (= (: tp) 1) 
          (prog (inc 'Bqty (: quantity)) 
                (inc 'Bprc (* (: buyprice) (: quantity))) ) 
          (prog (inc 'Sqty (: quantity))
                (inc 'Sprc (* (: sellprice) (: quantity)) ) ) ) ) )

(de evts::find(Rng)
   (solve
      (quote
         @Rng Rng
            (select (@Event)
               ((date +Event @Rng))
                  (range @Rng @Event date) ) )
      @Event) )
