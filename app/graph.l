
(must "Graph" Graph)

(menu, "Graph"
   (form NIL
      (<tab>
         # --- Remains tab
         (,"Remains"
            (<grid> "--"
               ,"Date"
                  (prog
                     (gui 'datfrom '(+Init +Var +DateField) (apply min (utils::dates)) '*TFrom 10)
                     (prin " - ")
                     (gui 'dattill '(+Init +Var +DateField) (apply max (utils::dates)) '*TTill 10) )
               ,"Quantity" (gui 'qty '(+Var +Init +NumField) '*TQty 10 10)
               ,"Chart type" (gui '(+Set +Init +Var +Map +TextField)
                  '((V) (and (: home rem) (type> (: home rem) V)) V)
                  *Bar
                  '*TType
                  '((*Bar . "bar") (*Pie . "pie") (*Dough . "doughnut")) '(*Bar *Pie *Dough) )
               (resetButton  '(datfrom dattill rem))
               (chartJSButton '(rem)) )
               (gui 'rem '(+ChartJS) 'bar 1024 768
                  '(tail *TQty
                     (by
                        '((X) (with (; X @@) (: quantity)))
                        sort
                        (solve
                           (quote
                              @Nr NIL
                              @Cat *TCat
                              @Dt (cons *TFrom (or *TTill T))
                              (select (@@)
                                 ((nr +Event @Nr) (date +Event @Dt))
                                    (range @Nr @@ nr)
                                    (range @Dt @@ date) ) ) ) ) )
                  '((: product title) (/ (: quantity) 100)) )
            NIL )

         # --- Sellings
         (,"Sellings"
            (<grid> "--"
               ,"Date"
                  (prog
                     (gui 'datfrom '(+Init +Var +DateField) (apply min (utils::dates)) '*TFrom 10)
                     (prin " - ")
                     (gui 'dattill '(+Init +Var +DateField) (apply max (utils::dates)) '*TTill 10) )
               ,"Quantity" (gui 'qty '(+Var +Init +NumField) '*TQty 10 10)
               ,"Chart type" (gui '(+Set +Init +Var +Map +TextField)
                  '((V) (and (: home rem) (type> (: home rem) V)) V)
                  *Bar
                  '*TType
                  '((*Bar . "bar") (*Pie . "pie") (*Dough . "doughnut")) '(*Bar *Pie *Dough) )
               (resetButton  '(datfrom dattill rem))
               (chartJSButton '(rem)) )
               (gui 'rem '(+ChartJS) 'bar 1024 768
                  '(tail *TQty
                     (by
                        '((X) (with (; X @@) (: quantity)))
                        sort
                        (solve
                           (quote
                              @Nr NIL
                              @Cat *TCat
                              @Dt (cons *TFrom (or *TTill T))
                              (select (@@)
                                 ((nr +Event @Nr) (date +Event @Dt))
                                    (range @Nr @@ nr)
                                    (range @Dt @@ date) ) ) ) ) )
                  '((: product title) (/ (: quantity) 100)) )
            NIL ) ) ) )

