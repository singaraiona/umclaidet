
### GUI ###
(de menu (Ttl . Prg)
   (action
      (html 0 Ttl *Css NIL
         (<ping> 7)
         (<layout>
            ((180 0 'menu)
               (<div> @
                  (expires)
                  (<menu>
                     (,"Home" "!work")
                     (,"Logout" (and *Login "!stop"))
                     (NIL (<hr>))
                     (T ,"Data"
                        (,"Products" (and (may Product) "app/product.l"))
                        (,"Suppliers" (and (may Supplier) "app/supplier.l"))
                        (,"Admissions" (and (may Admission) "app/admission.l")) ) ) )
               ((NIL NIL 'main)
                  (<div> @ (run Prg 1)) ) ) ) ) ) )

(de work ()
   (setq *Url "!work")
   (and (app) (setq *Menu 3))
   (menu "Учет товаров"
      (<h2> NIL "Учет товаров")
      (<img> "img/collect.png" "Logo" NIL "100%")
      (----)
      (loginForm) ) )

(de stop ()
   (logout)
   (work) )

(de choSup (Dst)
   (diaform '(Dst)
      (<grid> "-.-.-.-."
         ,"Number" (gui 'nr '(+Var +NumField) '*SupNr 10)
         ,"Name"   (gui 'name '(+Focus +Var +TextField) '*SupNm 30)
         (searchButton '(init> (: home query)))
         (resetButton '(nr name)) )
      (gui 'query '(+QueryChart) (cho)
         '(goal
            (quote
               @Nr (and *SupNr (cons @ T))
               @Nm *SupNm
               (select (@@)
                  ((nr +Supplier @Nr) (name +Supplier @Nm) )
                  (range @Nr @@ number)
                  (tolr @Nm @@ name) ) ) )
         3
         '((This) (list This (: nr) This (: name)) ) )
      (<table> 'chart (choTtl ,"Suppliers" 'nr '+Supplier)
         (quote
            (btn)
            (align "№")
            (NIL ,"Name") )
         (do (cho)
            (<row> (alternating)
               (gui 1 '(+DstButton) Dst)
               (gui 2 '(+NumField))
               (gui 3 '(+ObjView +TextField) '(: name)) ) ) )
      (<spread>
         (scroll (cho))
         (newButton T Dst '(+Supplier)
            '(nr genKey 'nr '+Supplier)
            'name *SupNm )
         (cancelButton) ) ) )

(de choProd (Dst)
   (diaform '(Dst)
      (<grid> "-.-.-.-.--"
         ,"Number" (gui 'nr '(+Focus +Var +NumField) '*ProdNr 10)
         ,"Brand" (gui 'brand '(+Var +TextField) '*ProdBr 30)
         ,"Name" (gui 'name '(+Var +TextField) '*ProdNm 30)
         ,"Supplier" (gui 'supplier '(+Var +TextField) '*ProdSup 30)
         (searchButton '(init> (: home query)))
         (resetButton '(nr brand name supplier query)) )
      (gui 'query '(+QueryChart) (cho)
         '(goal
            (quote
               @Nr (and *ProdNr (cons @ T))
               @Br *ProdBr
               @Nm *ProdNm
               @Sup *ProdSup
               (select (@@)
                  ((nr +Product @Nr)
                        (brand +Product @Br)
                        (name +Product @Nm)
                        (name +Supplier @Sup
                              (supplier +Product)) )
                  (range @Nr @@ nr)
                  (part @Br @@ brand)
                  (part @Nm @@ name)
                  (tolr @Sup @@ supplier name) ) ) )
         5
         '((This) (list This (: nr) This This (: supplier)) ) )
      (<table> 'chart (choTtl ,"Products" 'nr '+Product)
         (quote
            (btn)
            (align "#")
            (NIL ,"Brand")
            (NIL ,"Name")
            (NIL ,"Supplier") )
         (do (cho)
            (<row> (alternating)
               (gui 1 '(+DstButton) Dst)
               (gui 2 '(+NumField))
               (gui 3 '(+ObjView +TextField) '(: brand))
               (gui 4 '(+ObjView +TextField) '(: name))
               (gui 5 '(+ObjView +TextField) '(: name)) ) ) )
      (<spread>
         (scroll (cho))
         (newButton T Dst '(+Product)
            '(nr genKey 'nr '+Product)
            'brand *ProdBr
            'name *ProdNm )
         (cancelButton) ) ) )
