
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
               (resetButton '(datfrom dattill))
               (gui '(+OnClick +Button)
                  (let S (collect 'nr '+Event)
                     (chart::bar
                        "RemainsChart"
                        (head 20 (ttls))
                        (head 20 (qtys)) ) )
                  "Показать")
               NIL )
               (chart::new "RemainsChart" 1024 768) )
         (,"Sells"
            (<grid> "--"
               ,"Date"
                  (prog
                     (gui 'datfrom '(+Init +Var +DateField) (apply min (utils::dates)) '*TFrom 10)
                     (prin " - ")
                     (gui 'dattill '(+Init +Var +DateField) (apply max (utils::dates)) '*TTill 10) )
               ,"Category" (gui 'category '(+Var +TextField) '*TCat 10)
               (resetButton '(datfrom dattill))
               (gui '(+OnClick +Button)
                  (chart::bar
                     "SellsChart"
                     '("asd" "sd" "ert")
                     '(1 2 3) )
                  "Показать")
               NIL )
               (chart::new "SellsChart" 1024 768) ) ) ) )

