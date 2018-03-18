(de rem::fold(Grp)
   (let (Bqty 0
         Bprc 0 
         Sqty 0
         Sprc 0)
      (inc 'Nr) 
      (mapc rem::proc Grp)
      (with (car Grp)
         (let (Pqty (- Bqty Sqty)
               Pssum (* (: sellprice) (- Bqty Sqty))
               Pbsum (* (: buyprice)  (- Bqty Sqty))
               Pchrg (- (* (: sellprice) (- Bqty Sqty)) (* (: buyprice) (- Bqty Sqty))) )               
               (<row> (alternating)
                  (<+> Nr)
                  (<+> (: product category))
                  (<+> (: product title))
                  (<+> Pqty) 
                  (<+> (money (: sellprice)))
                  (<+> (money Pssum))
                  (<+> (money (: buyprice)))
                  (<+> (money Pbsum))
                  (<+> (money Pchrg))
                  (<-> (: product supplier name)) ) 
               (inc 'TotalSellSum Pssum) 
               (inc 'TotalBuySum Pbsum) 
               (inc 'TotalCharge Pchrg) ) ) ) )

(de rem::proc(Rec)
   (with Rec
      (if (= (: tp) 1) 
          (prog (inc 'Bqty (: quantity)) 
                (inc 'Bprc (* (: buyprice) (: quantity))) ) 
          (prog (inc 'Sqty (: quantity))
                (inc 'Sprc (* (: sellprice) (: quantity)) ) ) ) ) )

(de rem::find(Rng)
   (solve
      (quote
         @Rng Rng
            (select (@Event)
               ((date +Event @Rng))
                  (range @Rng @Event date) ) )
      @Event) )

(must "Remains" Report)

(menu ,"Remains"
   (<h3> NIL ,"Remains")
   (form NIL      
         (csv ,"Remains"
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
                     (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL)
                     (<+> ,"Date:")
                     (<-> (datStr (date))) )      
                     (at (0 . 10000) (or (flush) (throw))) ) ) ) ) )
      )

