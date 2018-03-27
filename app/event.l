
(must "Event" Event)

(menu, "Events"
   (idForm ,"Events" '(choEvt) 'nr '+Event T '(may Delete)
      '((: nr))
      (<hr>)
         (<grid> 3
            ,"Date" NIL          (gui '(+E/R +DateField) '(date : home obj) 10)
            ,"Event type" NIL    (gui 'tp '(+E/R +Map +TextField) '(tp : home obj) '((*Income . 1) (*Expense . 2)) '(*Income *Expense))
            ,"Title" (choProd 0) (gui '(+Set +E/R +Obj +TextField)
               upfields '(product : home obj) '(title +Product) 10)
            ,"Quantity" NIL      (gui '(+E/R +NumField)  '(quantity : home obj) 10)
            ,"Sell price" NIL    (gui '(+E/R +FixField)  '(sellprice : home obj) 2 10)
            ,"Buy price" NIL     (gui '(+E/R +FixField)  '(buyprice : home obj) 2 10)
            ,"Notes" NIL         (gui '(+E/R +TextField) '(notes : home obj) 10) )
      (<hr>)
      (newButton T Dst '(+Event)
         '(nr genKey 'nr '+Event)
         'date (date)
         'tp (val> (: home tp))) ) )

### Update rest fields when Product has been changed
(de upfields(V)
   (with (: home obj)
      (ifn (= V (: product))
         (let (Evts (rem::evts V)
               Qty  (rem::qty Evts)
               I    (last Evts) )
            (put!> This 'quantity Qty)
            (put!> This 'sellprice (; I sellprice))
            (put!> This 'buyprice  (; I buyprice)) ) ) )
   V )

# Find the last Event record in db mathes `Prod
(de rem::evts(Prod)
   (solve
      (quote
         @Prod Prod
         (select (@Event)
            ((product +Event @Prod))
               (same @Prod @Event product) ) )
      @Event ) )

(de rem::qty (Evts)
   (let Qty 0
      (mapc
         '((X)
            (with X
               (if
                  (= (: tp) 1)
                  (inc 'Qty (: quantity))
                  (dec 'Qty (: quantity)) ) ) )
         Evts )
      Qty ) )