
(must "Event" Event)

(menu, "Events"
   (idForm ,"Event" '(choEvt) 'nr '+Event T '(may Delete)
      '((: nr))
      (<hr>)
      (<grid> 3
         ,"Date" NIL          (gui '(+E/R +DateField) '(date : home obj) 10)
         ,"Event type" NIL    (gui 'tp '(+E/R +Map +TextField) '(tp : home obj) '((*Income . 1) (*Expense . 2)) '(*Income *Expense))
         ,"Code" (choProd 0)  (gui 'code '(+Set +E/R +Obj +NumField)
                               upfields '(product : home obj) '(nr +Product) 10)
         ,"Title" (choProd 0) (gui 'title '(+Set +E/R +Obj +TextField)
                               upfields '(product : home obj) '(title +Product) 10)
         ,"Quantity" NIL      (gui '(+E/R +FixField)  '(quantity : home obj) 2 10)
         ,"Sell price" NIL    (gui '(+E/R +FixField)  '(sellprice : home obj) 2 10)
         ,"Buy price" NIL     (gui '(+Set +E/R +FixField) 
             '((X) (ifn (= X (: home obj buyprice)) (/ (* X *StgsCurcy) 100) X))
             '(buyprice : home obj) 2 10)
         ,"Notes" NIL         (gui '(+E/R +TextField) '(notes : home obj) 10))
      (<hr>)
      (newButton T Dst '(+Event)
         '(nr genKey 'nr '+Event)
         'date 
            (cond 
               ((= 1 *StgsDat) (date))
               ((= 2 *StgsDat) (apply max (utils::dates))) )
         'tp (val> (: home tp)))))

### Update rest fields when Product has been changed
(de upfields(V)
   (if (= 1 *StgsFlds)
      (with (: home obj)
         (ifn (= V (: product))
            (let (Evts (rem::evts V)
                  Qty  (rem::qty Evts)
                  I    (last Evts) )
               (put!> This 'quantity Qty)
               (put!> This 'sellprice (with I (: sellprice)))
               (put!> This 'buyprice  (with I (: buyprice))) ) ) ) )
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