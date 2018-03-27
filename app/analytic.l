
(must "Analytic" Report)

(menu ,"Analytic"
   (<h3> NIL ,"Analytic")
   (form NIL
      (<grid> "-.-"
         ,"Date" NIL
         (prog
            (gui 'datfrom '(+Init +Var +DateField) (apply min (utils::dates)) '*InvFrom 10)
            (prin " - ")
            (gui 'dattill '(+Init +Var +DateField) (apply max (utils::dates)) '*InvTill 10) ) )
      (--)
      (gui '(+ShowButton) NIL
         '(csv ,"Analytic"
            (let (TotalQty 0
                  TotalSellQty 0
                  TotalSellPrice 0
                  TotalBuyQty 0
                  TotalBuyPrice 0
                  TotalCharge 0)
               (<table> 'chart NIL
                  (<!>
                     (quote
                        (NIL   ,"Date from")
                        (NIL   ,"Date till")
                        (align ,"Selling")
                        (align ,"Buying")
                        (align ,"Charge") ) )
                  (catch NIL (mapc anl::fold (by '((I) (; I product)) group (anl::find (cons *InvFrom (or *InvTill T)))))
                  (<row> (alternating)
                     (<+> (datStr *InvFrom))
                     (<+> (datStr *InvTill))
                     (<+> (money (/ TotalSellPrice 100)))
                     (<+> (money (/ TotalBuyPrice 100)))
                     (<-> (money (/ TotalCharge 100))) )
                  (at (0 . 10000) (or (flush) (throw))) ) ) ) ) )
      (resetButton '(datfrom dattill)) ) )

(de anl::fold (Grp)
   (let (Bqty 0
         Bprc 0
         Sqty 0
         Sprc 0)
      (mapc anl::proc Grp)
      (with (car Grp)
         (inc 'TotalCharge (- (* (: sellprice) Sqty) (* (: buyprice) Sqty))) )
      (inc 'TotalBuyQty Bqty)
      (inc 'TotalBuyPrice Bprc)
      (inc 'TotalSellQty Sqty)
      (inc 'TotalSellPrice Sprc) ) )

(de anl::proc (Rec)
   (with Rec
      (if (= (: tp) 1)
          (prog (inc 'Bqty (: quantity))
                (inc 'Bprc (* (: buyprice) (: quantity))) )
          (prog (inc 'Sqty (: quantity))
                (inc 'Sprc (* (: sellprice) (: quantity)) ) ) ) ) )

(de anl::find (Rng)
   (solve
      (quote
         @Rng Rng
            (select (@Event)
               ((date +Event @Rng))
                  (range @Rng @Event date) ) )
      @Event) )
