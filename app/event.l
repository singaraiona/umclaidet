
(must "Event" Event)

(menu, "Events"
   (idForm ,"Events" '(choEvt) 'nr '+Event T '(may Delete)
      '(" №" (: nr) " (" (datStr (: date)) ")")
      (<hr>)
      (<grid> 3
         ,"Number" NIL        (gui '(+E/R +NumField) '(nr : home obj) 10)
         ,"Event type" NIL    (gui '(+E/R +Map +TextField) '(tp : home obj) '(("Income" . 1) ("Expense" . 2)) '("Income" "Expense"))
         ,"Date" NIL          (gui '(+E/R +DateField) '(date : home obj) 10)
         ,"Title" (choProd 0) (gui '(+Set +E/R +Obj +TextField) upfields '(product : home obj) '(title +Product) 10)
         ,"Quantity" NIL      (gui '(+E/R +NumField) '(quantity : home obj) 10)
         ,"Sell price" NIL    (gui '(+E/R +FixField) '(sellprice : home obj) 2 10)
         ,"Buy price" NIL     (gui '(+E/R +FixField) '(buyprice : home obj) 2 10) )
      (<hr>) ) )

# Update rest fields when Product has been changed
(de upfields(V)
   (with (: home obj)
      (ifn (= V (: product)) 
         (let I (lastevt V)
            (put!> This 'quantity  (; I quantity))
            (put!> This 'sellprice (; I sellprice))
            (put!> This 'buyprice  (; I buyprice)) ) ) ) 
   V)

# Find the last Event record in db mathes `Prod
(de lastevt(Prod)
   (last
      (pilog
         (quote
            @Prod Prod
            (select (@Event)
               ((product +Event @Prod))
                  (same @Prod @Event product) ) )
         @Event) ) )
          