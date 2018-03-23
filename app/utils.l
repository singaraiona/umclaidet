# For testing only (instant login)
(de utils::login ()
   (setq *Login (pilog
      (quote
         @Nm "admin"
         (select (@User)
            ((nm +User @Nm))
               (tolr @Nm @User nm) ) )
      @User) ) )

# All dates +Event objects have
(de utils::dates ()
   (collect 'date '+Event NIL T 'date) )

# +Event type to string
(de utils::strTp (Tp)
   (if (= Tp 1) *Income (if (= Tp 2) *Expense NIL) ) )

# string to +Event type
(de utils::tpStr (S)
   (if (= S *Income) 1 (if (= S *Expense) 2 NIL) ) )

# Removes all spaces from sides of L and inside one
# if there are more then one space at a time
(de utils::clip (L)
   (clip
      (make
         (let Sp NIL
            (mapc
               '((C)
                  (if (= C " ")
                     (ifn Sp (prog (setq Sp T) (link C)))
                     (prog (setq Sp NIL) (link C)) ) )
               L ) ) ) ) )

# Prepare string for storing as object field
(de utils::normalize (Ln)
   (mapcar '((X) (pack (make (link (uppc (car X))) (link (cdr X)))))
      (mapcar utils::clip (split (chop Ln) "|"))) )

# Same as (obj) except evaluates fields
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

# Read file line by line and passes each line to callback fn
(de utils::parsefile (Fl Clb)
   (in Fl
      (let Fail NIL
         (while (and (not Fail) (line))
            (setq Fail (Clb (utils::normalize @)) ) )
      Fail ) ) )

# Creates GUI element for uploading files
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
               (link '(alert NIL "Неверный формат файла!" (<spread> (okButton))) ) ) ) ) ) ) )

# Search an supplier specified by name
(de utils::supplier (Nm)
   (collect 'name '+Supplier Nm) )

# Search an product specified by category and title
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

# Upload suppliers from CSV
(de utils::usups (Fl)
   (utils::parsefile Fl
      '((L)
            (let
               (Nm (pop L)
                Nr (or (; (last (utils::supplier Nm)) nr) (genKey 'nr '+Supplier)) )
                   (utils::obj ((+Supplier) nr Nr) name Nm)) NIL) ) )

# Upload products from CSV
(de utils::uprods (Fl)
   (utils::parsefile
      Fl
      '((L)
         (match '(@Cat @Ttl @Sup) L)
         (let
            (Cat (pop @Cat)
             Ttl (pop @Ttl)
             Sup (pop @Sup)
             Nr (or (; (last (utils::product Cat Ttl)) nr) (genKey 'nr '+Product)) )
               (if (and @Cat @Ttl @Sup)
                  (prog
                     (utils::obj ((+Product) nr Nr)
                     category Cat
                     title Ttl)
                     supplier (utils::supplier Sup) )
                 "Invalid products file!" ) )
         NIL ) ) )

# Upload events from CSV
(de utils::uevts (Fl)
   (utils::parsefile
      Fl
      '((L)
         (match '(@Dat @Tp @Cat @Ttl @Qty @Spr @Bpr) L)
         (if (and @Dat @Tp @Cat @Ttl @Qty @Spr @Bpr)
            (prog
               (utils::obj ((+Event) nr (genKey 'nr '+Event))
                  date (expDat (pop @Dat))
                  tp (utils::tpStr (pop @Tp))
                  product (utils::product (pop @Cat) (pop @Ttl))
                  quantity (format (pop @Qty))
                  sellprice (format (pack (split (chop (pop @Spr)) ",")) 2)
                  buyprice (format  (pack (split (chop (pop @Bpr)) ",")) 2) )
               NIL )
            "Invalid events file!" ) ) ) )
