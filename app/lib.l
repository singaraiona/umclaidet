(setq *Months
    '((1 . "января")
      (2 . "февраля")
      (3 . "марта")
      (4 . "апреля")
      (5 . "мая")
      (6 . "июня")
      (7 . "июля")
      (8 . "августа")
      (9 . "сентября")
      (10 . "октября")
      (11 . "ноября")
      (12 . "декабря") ) )

(de lib::xdate (Dt)
   (glue
      " "
      (make
         (let D (date Dt)
            (link (caddr D))
            (link (cdr (asoq (cadr D) *Months)))
            (link (car D))
            (link "года") ) ) ) )

(de lib::chunks (L I U)
  (make
     (link (cut I 'L))
     (ifn (=0 (length L))
        (until (=0 (length L))
           (link (cut U 'L)) ) ) ) )

(de hsep (V)
   (down V)
   (hline 0 470 0) )

(de print::events (List EvTp)
   (pdf *A4-DX *A4-DY (tmp ,"Invoice.pdf")
      (width "0.5")
      (let
         (Chnks (lib::chunks List 44 64)
          Pgs (length Chnks)
          Fmt (10 180 45 45 50 45 50 45)
          Cnt 0 Tbsum 0 Tssum 0 Tchrg 0
          LstDt (apply max (utils::dates)) )
         (mapc
            '((Lst)
               (page
                  (window 60 0 470 0
                     (if (=1 *Page)
                        (prog
                           (down 80)
                           (bold
                              (font (25 . "Times-Roman")
                                 (if (= 1 EvTp)
                                    (ps 0 ,"Приходная накладная")
                                    (if (= 2 EvTp)
                                       (ps 0 ,"Расходная накладная")
                                       (ps 0 ,"Приходно-расходная накладная")) ) ) )
                           (hsep 10)
                           (down 20)
                           (font (12 . "Times-Roman") (ps T ,(pack "От " (lib::xdate LstDt))))
                           (down 20)
                           (font (12 . "Times-Roman") (ps T ,"Магазин «Наталино» ______ ФОП Азаров А.И."))
                           (hsep 80) )
                        (hsep 20) )

                     # --- Columns headers
                     (font (8 . "Times-Roman"))
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

                     # --- Values
                     (font (7 . "Times-Roman"))
                     (mapc
                        '((C)
                           (with C
                              (let (Ttl  (: product title) Qty  (: quantity) Bpr  (: buyprice) Bsum (* Bpr Qty) Spr  (: sellprice) Ssum (* Spr Qty) Chrg (- Ssum Bsum))
                                 (inc 'Tbsum Bsum)
                                 (inc 'Tssum Ssum)
                                 (inc 'Tchrg Chrg)

                                 # --- Render vals
                                 (table Fmt
                                    (ps T ,(inc 'Cnt))
                                    (ps T ,Ttl)
                                    (ps T ,Qty)
                                    (ps T ,(money Bpr))
                                    (ps T ,(money Bsum))
                                    (ps T ,(money Spr))
                                    (ps T ,(money Ssum))
                                    (ps T ,(money Chrg)) )
                                  (hsep 5) ) ) )
                        Lst )

               # --- Total
               (if (= *Page Pgs)
                  (prog
                     (bold
                        (table Fmt
                           NIL
                           (ps T ,"Итого:")
                           NIL
                           NIL
                           (ps T ,(money Tbsum))
                           NIL
                           (ps T ,(money Tssum))
                           (ps T ,(money Tchrg)) ) )
                     (hsep 5) ) ) )
               (down 820)
               (font 6 (ps 0 ,(text ,"Страница @1" *Page))) ) )
            Chnks ) ) ) )

(de print::products (List)
   (pdf *A4-DX *A4-DY (tmp ,"Invoice.pdf")
      (width "0.5")
      (let
         (Chnks (lib::chunks List 35 50)
          Pgs (length Chnks)
          Fmt (50 20 100 20 280) )
         (mapc
            '((Lst)
               (page
                  (window 60 0 470 0
                     (if (=1 *Page)
                        (prog
                           (down 80)
                           (bold
                              (font (25 . "Times-Roman")
                                 (ps 0, "Коды товаров") ) )
                           (hsep 10)
                           (down 20)
                           (font (12 . "Times-Roman") (ps T ,(pack "От " (lib::xdate (date)))))
                           (down 20)
                           (font (12 . "Times-Roman") (ps T ,"Магазин «Наталино» ______ ФОП Азаров А.И."))
                           (hsep 80) )
                        (hsep 20) )

                     # --- Columns headers
                     (font (12 . "Times-Roman"))
                     (bold
                        (table Fmt
                           (ps T ,"Код")
                           NIL
                           (ps NIL ,"Категория")
                           NIL
                           (ps NIL ,"Наименование") ) )
                     (hsep 5)

                     # --- Values
                     (font (10 . "Times-Roman"))
                     (mapc
                        '((C)
                           (with C
                              # --- Render vals
                              (table Fmt
                                 (ps T ,(: nr))
                                 NIL
                                 (ps NIL ,(: category name))
                                 NIL
                                 (ps NIL ,(: title)) ) )
                               (hsep 5) )
                           Lst )
                     (down 20)
                     (font 6 (ps 0 ,(text ,"Страница @1" *Page))) ) ) )
            Chnks ) ) ) )
