(de utils::login ()
   (setq *Login (pilog
      (quote
         @Nm "admin"
         (select (@User)
            ((nm +User @Nm))
               (tolr @Nm @User nm) ) )
      @User) ) )

(de utils::strTp (Tp)
   (if (= Tp 1) *Income (if (= Tp 2) *Expense NIL) ) )

(de utils::tpStr (S)
   (if (= S *Income) 1 (if (= S *Expense) 2 NIL) ) )

(de utils::strip (Ln)
   (mapcar '((L) (pack (clip L))) (split (chop Ln) "|")) )

(de utils::obj Lst
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

(de utils::parsefile (Fl Clb)
   (in Fl
      (let Fail NIL
         (while (and (not Fail) (line))
            (setq Fail (Clb (utils::strip @)) ) )
      Fail ) ) )

(de utils::upfile Args
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

(de utils::supplier (Nm)
   (pilog
      (quote
         @Nm Nm
         (select (@Supplier)
            ((name +Supplier @Nm))
               (same @Nm @Supplier name) ) )
      @Supplier ) )

(de utils::suppliers (Fl)
   (utils::parsefile Fl
      '((L) (utils::obj ((+Supplier) name (pop L))) NIL) ) )

(de utils::products (Fl)
   (utils::parsefile
      Fl
      '((L)
         (match '(@Cat @Ttl @Sup) L)
         (if (and @Cat @Ttl @Sup)
            (prog
               (utils::obj ((+Product)
                  category (pop @Cat)
                  title (pop @Ttl))
                  supplier (utils::supplier (pop @Sup)) )
            NIL )
            "Invalid products file!" ) ) ) )

(de utils::product (Cat Ttl)
   (pilog
      (quote
         @Cat Cat
         @Ttl Ttl
         (select (@Product)
            ((category +Product @Cat) (title +Product @Ttl))
               (same @Cat @Product category)
               (same @Ttl @Product title) ) )
      @Product ) )

(de utils::events (Fl)
   (utils::parsefile
      Fl
      '((L)
         (match '(@Dat @Tp @Cat @Ttl @Qty @Spr @Bpr) L)
         (utils::obj ((+Event)
            date (expDat (pop @Dat))
            tp (utils::tpStr (pop @Tp))
            product (utils::product (pop @Cat) (pop @Ttl))
            quantity (format (pop @Qty))
            sellprice (format (glue "." (split (chop (pop @Spr)) ",")) 2)
            buyprice (format (glue "." (split (chop (pop @Bpr)) ",")) 2) ) ) ) ) )
