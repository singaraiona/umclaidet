
(de toPdf (List)
   (pdf *A4-DX *A4-DY (tmp ,"Invoice.pdf")
      (font (11 . "arial"))
      (width "0.5")
        (page
           (image "img/collect.png" "image/png" 420 0 120)
                  (ifn (=1 *Page)
                     (indent 60
                        (down 40)
                        (font 9 (ps (text ,"Page @1" *Page)))
                        (down 80)
                        (hline 0 470 -8) )
                     (window 380 120 120 30
                        (font 21 (ps 0 ,"Invoice")) )
                     (brief NIL 8 "Shop"
                        (ps)
                        (ps (text ,"Income"))
                        (ps (text ,"Expense")) ) ) )
         (page
           (image "img/collect.png" "image/png" 420 0 120)
                  (ifn (=1 *Page)
                     (indent 60
                        (down 40)
                        (font 9 (ps (text ,"Page @1" *Page)))
                        (down 80)
                        (hline 0 470 -8) )
                     (window 380 120 120 30
                        (font 21 (ps 0 ,"Invoice")) )
                     (brief NIL 8 "Shop"
                        (ps)
                        (ps (text ,"Income"))
                        (ps (text ,"Expense")) ) ) )
         ) )
