
(de toPdf (List)
   (pdf *A4-DX *A4-DY (tmp ,"Invoice.pdf")
         (width "0.5")
         (page
            (indent 60
               (down 80)
               (bold (font (25 . "serif") (ps 0 ,"Приходная накладная"))) )
            (down 10)
            (hline 0 470 90)
            (down 10)
            (font (12 . "serif") (ps 0 ,"От «_____» ______________ 2018 года"))
            (down 10)
            (font (14 . "serif") (ps 0 ,"Магазин Наталино _______________ ФОП Азаров А.И."))
            (down 80)
            (indent 60
               (hline 0 470 -8)
               (let Fmt (14 6 80 80 80 80)
                  (bold
                     (table Fmt NIL NIL
                        (ps 0 ,"#")
                     (ps T ,"Title")
                     (ps T ,"Quantity")
                     (ps T ,"Sell price")
                     (ps T ,"Sell sum")
                     (ps T ,"Buy price")
                     (ps T ,"Buy sum")
                     (ps T ,"Charge")
                     ) ) ) )
             ) ) )

