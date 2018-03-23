(de hsep (V)
   (down V)
   (hline 0 470 -8) )

(de toPdf (List EvTp)
   (pdf *A4-DX *A4-DY (tmp ,"Invoice.pdf")
      (width "0.5")
      (page
         (down 80)
         (indent 60
            (if (=1 *Page)
               (prog
                  (bold
                     (font (25 . "serif")
                        (if (= 1 EvTp) (ps 0 ,"Приходная накладная")
                                       (if (= 2 EvTp)
                                          (ps 0 ,"Расходная накладная")
                                          (ps 0 ,"Приходно-расходная накладная")) ) ) )
                  (hsep 10)
                  (down 20)
                  (font (12 . "serif") (ps T ,"От «_____» ______________ 2018 года"))
                  (down 10)
                  (font (12 . "serif") (ps T ,"Магазин Наталино _______________ ФОП Азаров А.И."))
                  (hsep 80) ) )
            (font (10 . "Times-Roman"))
            (let Fmt (10 180 45 45 50 45 50 45)
               # Columns headers
               (bold
                  (table Fmt
                     (ps T ,"#")
                     (ps T ,"Наимен.")
                     (ps T ,"К-во")
                     (ps T ,"Цена з.")
                     (ps T ,"Сумма")
                     (ps T ,"Цена р.")
                     (ps T ,"Сумма")
                     (ps T ,"Т.Н.") ) )
               (hsep 5)
               # Values
               (font (9 . "Times-Roman"))
               (let (Cnt 0
                     Tbsum 0
                     Tssum 0
                     Tchrg 0)
                  (mapc
                     '((C)
                        (with C
                           (let (Ttl  (: product title)
                                 Qty  (: quantity)
                                 Bpr  (: buyprice)
                                 Bsum (* Bpr Qty)
                                 Spr  (: sellprice)
                                 Ssum (* Spr Qty)
                                 Chrg (- Ssum Bsum) )
                              (inc 'Tbsum Bsum)
                              (inc 'Tssum Ssum)
                              (inc 'Tchrg Chrg)
                              # Render vals
                              (table Fmt
                                 (ps T ,(inc 'Cnt))
                                 (ps T ,Ttl)
                                 (ps T ,Qty)
                                 (ps T ,(money Bpr))
                                 (ps T ,(money Bsum))
                                 (ps T ,(money Spr))
                                 (ps T ,(money Ssum))
                                 (ps T ,(money Chrg)) ) )
                        (hsep 5) ) )
                     List )
                  # Total
                  (bold
                     (table Fmt
                        NIL
                        (ps T ,"Итого:")
                        NIL
                        NIL
                        (ps T ,(money Tbsum))
                        NIL
                        (ps T ,(money Tssum))
                        (ps T ,(money Tchrg)) ) ) )
               (hsep 5) )

             ) ) ) )


