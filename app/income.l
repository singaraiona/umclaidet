
(must "Income" Income)

(menu, "Income"
   (idForm ,"Income" '(choInc) 'nr '+Income T '(may Delete)
      '(" №" (: nr) " (" (datStr (: date)) ")")
      (<hr>)
      (setq *Qty 0)
      (setq *Spr 0)
      (setq *Bpr 0)
      (<grid> 3
         ,"Number" NIL        (gui 'nmr '(+E/R +NumField) '(nr : home obj) 10)
         ,"Date" NIL          (gui 'dat '(+E/R +DateField) '(date : home obj) 10)
         ,"Title" (choProd 0) (gui 'ttl '(+Set +E/R +Obj +TextField)
            '(prog
             (msg "VAL: " (val> (: home dat)))
             (with (: home obj product)
                      #(set '*Qty (; (lastInc (: title)) quantity))
                      #(setq *Qty 66)

                      This) )
            '(product : home obj)  '(title +Product) 10)
         ,"Quantity" NIL      (gui 'qty '(+E/R +NumField) '(quantity : home obj) 10)
         ,"Sell price" NIL    (gui 'spr '(+Var +E/R +FixField) '*Spr '(sellprice : home obj) 2 10)
         ,"Buy price" NIL     (gui 'bpr '(+Var +E/R +FixField) '*Bpr '(buyprice : home obj) 2 10) )
      (<hr>) ) )



(de lastInc(Ttl)
      (msg "TTL: " Ttl)
      (last
         (pilog
            (quote
               @Ttl Ttl
               (select (@Income)
                  ((title +Income @Title))
                    (tolr @Ttl @Income title) ) )
         @Income ) ) )