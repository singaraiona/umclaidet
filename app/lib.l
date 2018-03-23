(de hsep (V)
   (down V)
   (hline 0 470 -8) )

(de toPdf (List)
   (pdf *A4-DX *A4-DY (tmp ,"Invoice.pdf")
         (width "0.5")
         (page
            (down 80)
            (indent 60
               (bold (font (25 . "serif") (ps 0 ,"Приходная накладная")))
               (hsep 10)
               (down 20)
               (font (12 . "serif") (ps T ,"От «_____» ______________ 2018 года"))
               (down 10)
               (font (12 . "serif") (ps T ,"Магазин Наталино _______________ ФОП Азаров А.И."))
               (hsep 80)
               (font (12 . "Times-Roman"))
               (let Fmt (20 90 60 60 60 60 60 60)
                  # Columns headers
                  (bold
                     (table Fmt
                        (ps T ,"#")
                        (ps T ,"Наимен.")
                        (ps T ,"Кол-во")
                        (ps T ,"Цена зк.")
                        (ps T ,"Сумма")
                        (ps T ,"Цена рл.")
                        (ps T ,"Сумма")
                        (ps T ,"Т.Н.") ) )
                  (hsep 5)
                  # Values
                  (font (10 . "Times-Roman"))
                  (mapc
                     '((C)
                        (table Fmt
                           (ps T ,1)
                           (ps T ,"Паровоз")
                           (ps T ,99)
                           (ps T ,(format 3321 2))
                           (ps T ,(format 1299 2))
                           (ps T ,(format 3456 2))
                           (ps T ,(format 12466 2))
                           (ps T ,(format 5556 2)) )
                        (hsep 5) )
                     List )
                  # Total
                  (bold
                     (table Fmt
                        NIL
                        (ps T ,"Итого:")
                        NIL
                        NIL
                        (ps T ,(format 441219 2))
                        NIL
                        (ps T ,(format 12466 2))
                        (ps T ,(format 12466 2)) ) )
                  (hsep 5) ) ) ) ) )


