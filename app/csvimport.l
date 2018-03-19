(must "CSV Import" Import)

(action
   (html 0 "+TimeField" "@lib.css" NIL
      (form NIL
         (gui '(+TimeField) 8)
         (gui '(+JS +Button) "Print value"
            '(msg (tim$ (val> (: home gui 1)))) )
         (gui '(+JS +Button) "Set to \"now\""
            '(set> (: home gui 1) (time)) ) ) ) )