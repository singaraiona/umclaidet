(de import::strip (Ln)
   (mapcar '((L) (pack (clip L))) (split (chop Ln) "|")) )

(de import::obj Lst
   (let (ReqLst (pop 'Lst)
         ReqCls (pop 'ReqLst)
         l1 (make (link ReqCls)
                  (while ReqLst
                     (link (pop 'ReqLst))
                     (link (eval (pop 'ReqLst))) ) )
         Obj (apply request l1) )
   (while Lst
      (put> Obj (pop 'Lst) (eval (pop 'Lst))) )
   Obj) )

(de import::parsefile (Fl Clb)
   (in Fl
      (while (line)
         (Clb (import::strip @)) ) )
   NIL )

(de import::upfile Args
   (let Clb (pop 'Args)
      (gui '(+Tiny +UpField))
      (gui '(+Drop +Button)
         '(field -1)
         "Загрузить"
         (make
            (link 'when)
            (link '(: drop))
            (link (make
               (link 'ifn)
               (link (make
                  (link Clb)
                  (link '@) ) )
               (link '(commit))
               (link '(alert NIL "Ошибка импорта: неверный формат файла!" (<spread> (okButton))) ) ) ) ) ) ) )

(de import::supplier (Nm)
   (pilog
      (quote
         @Nm Nm
         (select (@Supplier)
            ((name +Supplier @Nm))
               (same @Nm @Supplier name) ) )
      @Supplier ) )

(de import::suppliers (Fl)
   (import::parsefile Fl
      '((L) (import::obj ((+Supplier) name (pop L))) ) ) )

(de import::products (Fl)
   (import::parsefile
      Fl
      '((L)
         (match '(@Cat @Ttl @Sup) L)
         (import::obj ((+Product)
            category (pop @Cat)
            title (pop @Ttl))
            supplier (import::supplier (pop @Sup)) ) ) ) )

(de import::product (Cat Ttl)
   (pilog
      (quote
         @Cat Cat
         @Ttl Ttl
         (select (@Product)
            ((category +Product @Cat) (title +Product @Ttl))
               (same @Cat @Product category)
               (same @Ttl @Product title) ) )
      @Product ) )

(de import::events (Fl)
   (import::parsefile
      Fl
      '((L)
         (match '(@Dat @Tp @Cat @Ttl @Qty @Spr @Bpr) L)
         (import::obj ((+Event)
            date (expDat (pop @Dat))
            tp (utils::tpStr (pop @Tp))
            product (import::product (pop @Cat) (pop @Ttl))
            quantity (format (pop @Qty))
            sellprice (format (glue "." (split (chop (pop @Spr)) ",")) 2)
            buyprice (format (glue "." (split (chop (pop @Bpr)) ",")) 2) ) ) ) ) )
