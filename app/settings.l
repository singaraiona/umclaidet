(must "Settings" Import)

(menu, "Settings"
   (form "Settings"
      (<tab>
         (,"Events"
            (<grid> 2    
               ,"Date selection" (gui '(+Init +Set +Map +TextField) *StgsDat '((X) (setq *StgsDat X)) '(("Текущая" . 1) ("Последняя" . 2)) '("Текущая" "Последняя"))
               ,"Fields autofill" (gui '(+Init +Set +Map +TextField) *StgsFlds '((X) (setq *StgsFlds X)) '(("Да" . 1) ("Нет" . 2)) '("Да" "Нет")) 
               ,"Currency rate" (gui '(+Init +Set +FixField) *StgsCurcy '((X) (setq *StgsCurcy X)) 2 10) )
         ) ) ) )
