
(must "Graph" Graph)

(menu, "Graph"
   (form NIL
      (<tab>
         (,"Remains"
            (<grid> "--"
               ,"Date"
                  (prog
                     (gui 'datfrom '(+Init +Var +DateField) (apply min (utils::dates)) '*TFrom 10)
                     (prin " - ")
                     (gui 'dattill '(+Init +Var +DateField) (apply max (utils::dates)) '*TTill 10) )
               ,"Quantity" (gui 'qty '(+Var +NumField) '*TQty 10)
               (resetButton  '(datfrom dattill rem))
               (chartJSButton '(rem)) )
               (gui 'rem '(+ChartJS) 'bar 1024 768
                  '(head *TQty
                     (solve
                        (quote
                           @Nr NIL
                           @Cat *TCat
                           @Dt (cons *TFrom (or *TTill T))
                           (select (@@)
                              ((nr +Event @Nr) (date +Event @Dt))
                                 (range @Nr @@ nr)
                                 (range @Dt @@ date) ) ) ) )
                  '((: product title) (/ (: quantity) 100)) )
            NIL ) ) ) )

