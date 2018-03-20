(de import::strip (Ln)
   (pack (clip (chop Ln))) )

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
         (Clb @) ) ) )

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
               (link (make
                  (link 'prog '(commit) '(init> (: home query))) ) )
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
      '((L) (import::obj ((+Supplier) name (import::strip L))) ) )
   NIL )

(de import::products (Fl)
   (import::parsefile
      Fl
      '((L)
         (match '(@Cat @Ttl @Sup) (mapcar pack (split (chop L) "|")))
         (import::obj ((+Product)
            category (pop @Cat)
            title (pop @Ttl))
            supplier (import::supplier (pop @Sup)) ) ) )
   NIL )

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
         (match '(@Dat @Tp @Cat @Ttl @Qty @Spr @Bpr) (mapcar pack (split (chop L) "|")))
         (import::obj ((+Event) date (strDat (pop @Dat))
                         tp (pop @Tp))
                         product (import::product (pop @Cat) (pop @Ttl))
                         quantity (pop @Qty)
                         sellprice (pop @Spr)
                         buyprice (pop @Bpr) ) ) )
   NIL )