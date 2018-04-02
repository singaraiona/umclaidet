
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
               (resetButton '(datfrom dattill rem))
               (searchButton '(init> (: home rem))) )
               (gui 'rem '(+ChartJS) 'bar 1024 768 '(ttls) '(qtys) )
            NIL ) ) ) )

