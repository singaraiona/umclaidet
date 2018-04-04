
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
               ,"Category" (gui 'category '(+Var +TextField) '*TCat 10)
               (resetButton  '(datfrom dattill rem))
               (chartJSButton '(rem)) )
               (gui 'rem '(+ChartJS) 'bar 1024 768
                  '(solve
                     (quote
                        @Nr NIL
                        @Dt (cons *InvFrom (or *InvTill T))
                        (select (@@)
                           ((nr +Event @Nr) (date +Event @Dt))
                              (range @Nr @@ nr)
                              (range @Dt @@ date) ) ) )
                  '((: product title) (: quantity)) )
            NIL ) ) ) )

