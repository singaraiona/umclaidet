
### All dates +Event objects have
(de utils::dates ()
   (collect 'date '+Event NIL T 'date) )

### +Event type to string
(de utils::strTp (Tp)
   (if (= Tp 1) *Income (if (= Tp 2) *Expense NIL) ) )

### string to +Event type
(de utils::tpStr (S)
   (if (= S *Income) 1 (if (= S *Expense) 2 NIL) ) )

### Removes all spaces from sides of L and inside one
### if there are more then one space at a time
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

### Prepare string for storing as object field
(de utils::normalize (Ln)
   (mapcar '((X) (pack (make (link (uppc (car X))) (link (cdr X)))))
      (mapcar utils::clip (split (chop Ln) "|"))) )

### Same as (obj) except evaluates fields
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

### Read file line by line and passes each line to callback fn
(de utils::parsefile (Fl Clb)
      (in Fl
         (let Fail NIL
            (while (and (not Fail) (line))
               (setq Fail (Clb (utils::normalize @)) ) )
         Fail ) ) )

### Generate next key for +Category
(de utils::catkey ()
   (genKey 'nr '+Category) )

### Generate next key for +Product
(de utils::prodkey (Cat)
   (let (Ord (+ (with Cat (* (- (: nr) 1) *ProdsInCat)) 1)
         Cnt 0
         Nrs (sort (make (mapc '((X) (link (with X (: nr))) (inc 'Cnt)) (with Cat (: products)))))
         Last (last Nrs) )
       (cond
          ((= Cnt *ProdsInCat) NIL)
          ((= Cnt 0) Ord)
          ((= Cnt 1) (+ Ord 1))
          (T
             (car
                (diff
                   (range Ord (inc Last))
                   Nrs ) ) ) ) ) )

### Removes all non-numbers from
### string to be formatted
(de utils::format (L)
    (let (F NIL
          S (pack
               (make
                  (mapc
                     '((C) (if (= C ",") (prog (setq F T) (link ".")) (and (format C) (link C))))
                     (chop L) ) ) ) )
          (if F (format S 2) (* (format S) 100)) ) )

### Creates GUI element for uploading files
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

### Search an supplier specified by name
(de utils::supplier (Nm)
   (pilog
      (quote
         @Nm Nm
         (select (@Supplier)
            ((name +Supplier @Nm))
               (same @Nm @Supplier name) ) )
      @Supplier ) )

### Search a category specified by name
(de utils::category (Nm)
   (pilog
      (quote
         @Nm Nm
         (select (@Category)
            ((name +Category @Nm))
               (same @Nm @Category name) ) )
      @Category ) )

### Search an product specified by category and title
(de utils::product (Cat Ttl)
   (find
      '((X) (with X (= (: title) Ttl)))
      (with Cat (: products)) ) )

### Upload suppliers from CSV
(de utils::usups (Fl)
   (utils::parsefile Fl
      '((L)
         (let
            (Nm (and L (pop L))
             Nr (or (with (last (utils::supplier Nm)) (: nr)) (genKey 'nr '+Supplier)) )
                (utils::obj ((+Supplier) nr Nr) name Nm))
            NIL ) ) )

### Upload categories from CSV
(de utils::ucats (Fl)
   (utils::parsefile Fl
      '((L)
         (let
            (Nm (and L (pop L))
             Nr (or (with (last (utils::category Nm)) (: nr)) (genKey 'nr '+Category)) )
                (utils::obj ((+Category) nr Nr) name Nm))
            NIL ) ) )

### Upload products from CSV
(de utils::uprods (Fl)
   (utils::parsefile
      Fl
      '((L)
         (match '(@Cat @Ttl @Sup) L)
         (let
            (Cat (and @Cat (utils::category (pop @Cat)))
             Ttl (and @Ttl (pop @Ttl))
             Sup (and @Sup (utils::supplier (pop @Sup)))
             Nr (or (with (utils::product Cat Ttl) (: nr)) (utils::prodkey Cat)) )
            (msg (text "PROD IMPORT --- Nr:@1 Cat:@2 Ttl:@3" Nr Cat Ttl))
            (if (and Cat Ttl)
               (prog
                  (utils::obj ((+Product) nr Nr)
                  category Cat
                  title Ttl
                  supplier Sup ) )
              "Invalid products file!" ) )
         NIL ) ) )

### Upload events from CSV
(de utils::uevts (Fl)
   (utils::parsefile
      Fl
      '((L)
         (match '(@Dat @Tp @Cat @Ttl @Qty @Spr) L)
         (let
            (Dt   (and @Dat (expDat (pop @Dat)))
             Tp   (and @Tp (utils::tpStr (pop @Tp)))
             Cat  (and @Cat (utils::category (pop @Cat)))
             Ttl  (and @Ttl (pop @Ttl))
             Prod (utils::product Cat Ttl)
             Qty  (and @Qty (utils::format (pop @Qty)))
             Spr  (and @Spr (utils::format (pop @Spr)))
             Bpr  0
             Nts  "" )
            (msg (text "EVENT IMPORT --- Dt: @1 Tp: @2 Cat @3 Ttl @4 Prod @5" Dt Tp Cat Ttl Prod))
            (if
               (and Dt Tp Cat Ttl Prod Qty Spr)
               (prog
                  (utils::obj ((+Event) nr (genKey 'nr '+Event))
                     date Dt
                     tp Tp
                     product Prod
                     quantity Qty
                     sellprice Spr
                     buyprice Bpr
                     notes Nts )
                  NIL )
               "Invalid events file!" ) ) ) ) )

(de utils::load (Dir Clb)
   (msg (pack Dir " --loading..."))
   (mapc '((X) (Clb (glue "/" (list Dir X)))) (dir Dir) )
   (msg (pack Dir " --done.")) )

(de utils::import ()
   (msg "utils::import")
   (utils::load  "init/categories" utils::ucats)
   (utils::load  "init/tovar" utils::uprods)
   (utils::load  "init/prihod" utils::uevts)
   (commit) )

(de utils::preload ())