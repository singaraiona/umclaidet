
(must "Remains" Report)

(menu ,"Remains"
   (<h3> NIL ,"Remains")
   (form NIL
      (<grid> "-.-"
         ,"Date" NIL
         (prog
            (gui 'datfrom '(+Init +Var +DateField) (apply min (utils::dates)) '*InvFrom 10)
            (prin " - ")
            (gui 'dattill '(+Init +Var +DateField) (apply max (utils::dates)) '*InvTill 10) )
         ,"Category" (choCat 0) (gui 'cat '(+Var +Obj +TextField)
               '*InvCat
               '(name +Category) 10)
         ,"Title" NIL (gui 'prd '(+Var +TextField) '*InvPrd 10)
         ,"Show" NIL (gui '(+Init +Set +Map +TextField)
            *StgsFilter
            '((X) (setq *StgsFilter X))
            '(("Все" . 1) ("Отрицат." . 2)) '("Все" "Отрицат.")) )
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
                        (align ,"Code")
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
                        (catch NIL (pgroup (rem::find (cons *InvFrom (or *InvTill T)) (; *InvCat name) *InvPrd)))
                  (<row> 'nil
                     (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL)
                     (<+> ,"Total:")
                     (<+> (money (/ TotalSellSum 100)))
                     (<+> NIL)
                     (<+> (money (/ TotalBuySum 100)))
                     (<+> (money (/ TotalCharge 100)))
                     (<-> NIL) )
                  (<row> 'nil
                     (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL) (<+> NIL)
                     (<+> ,"Date from")
                     (<+> (datStr *InvFrom))
                     (<+> ,"Date till")
                     (<-> (datStr *InvTill)) )
                  (at (0 . 10000) (or (flush) (throw))) ) ) ) ) )
      (resetButton '(datfrom dattill cat)) ) )

(de pgroup (L)
   (mapc
      '((P)
         (mapc
            rem::fold
            (by '((X) (with X (: sellprice))) group P)) )
      (by '((I) (with I (: product))) group L) ) )

(de grp::show (Grp Qty)
   (with Grp
      (let Mins (filter '((X) (> 0 X))
         (list (: sellprice) (: buyprice) Qty
            (- (* (: sellprice) Qty) (* (: buyprice) Qty)) ) )
      (or (= 1 *StgsFilter) Mins) ) ) )

(de rem::fold (Grp)
      (inc 'Nr)
      (let Qty 0
         (mapc rem::proc Grp)
         (with (car Grp)
            (let (Ssum (* (: sellprice) Qty)
                  Bsum (* (: buyprice) Qty)
                  Chrg (- Ssum Bsum))
               (if (grp::show This Qty)
                  (<row> (alternating)
                     (<+> Nr)
                     (<+> (: product nr))
                     (<+> (: product category name))
                     (<+> (: product title))
                     (<+> (money Qty))
                     (<+> (money (: sellprice)))
                     (<+> (money (/ Ssum 100)))
                     (<+> (money (: buyprice)))
                     (<+> (money (/ Bsum 100)))
                     (<+> (money (/ Chrg 100)))
                     (<-> (: product supplier name))) )
               (inc 'TotalSellSum Ssum)
               (inc 'TotalBuySum Bsum)
               (inc 'TotalCharge Chrg)))))

(de rem::proc (Rec)
   (with Rec
      (if (= (: tp) 1)
          (prog (inc 'Qty (: quantity))
                (inc 'Ssum (* (: sellprice) (: quantity)))
                (inc 'Bsum (* (: buyprice) (: quantity))))
          (prog (dec 'Qty (: quantity))
                (dec 'Ssum (* (: sellprice) (: quantity)))
                (dec 'Bsum (* (: buyprice) (: quantity)))))))

(de rem::find (Dt Cat Prd)
   (solve
      (quote
         @Nr '(NIL . T)
         @Dt '(NIL . T)
         @Prd Prd
         @Cat Cat
             (select (@Event)
               ((nr +Event @Nr)
                (date +Event @Dt)
                (title +Product @Prd (product +Event)))
               (range @Nr @Event nr)
               (range @Dt @Event date)
               (tolr @Prd @Event product title)
               (same @Cat @Event product category name)))
      @Event ) )
