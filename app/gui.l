
(de menu (Ttl . Prg)
   (action
      (html 0 Ttl *Css NIL
         (<ping> 7)
         (<layout>
            ((180 0 'menu)
               (<div> @
                  (expires)
                  (<menu>
                     (T ,"Main menu"
                        (,"Home" "!work")
                        (,"Logout" (and *Login "!stop")) )
                     (NIL (<hr>))
                     (T ,"Data"
                        (,"Suppliers" (and (may Supplier) "app/supplier.l"))
                        (,"Products" (and (may Product) "app/product.l")) )
                     (NIL (<hr>))
                     (T ,"Registration"
                        (,"Events" (and (may Event) "app/event.l")) )
                     (NIL (<hr>))
                     (T ,"Import"
                        (,"Import from CSV" (and (may Import) "app/import.l")) )
                     (NIL (<hr>))
                     (T ,"Report"
                        (,"Remains" (and (may Report) "app/remains.l"))
                        (,"Analytic" (and (may Report) "app/analytic.l")) ) ) )
               ((NIL NIL 'main)
                  (<div> @ (run Prg 1)) ) ) ) ) ) )

(de work ()
   (setq *Url "!work")
   (and (app) (setq *Menu 15))
   (menu *ProjectTitle
      (<h2> NIL *ProjectTitle)
      (<img> "img/collect.png" "Logo" NIL "100%")
      (----)
      (loginForm) ) )

(de stop ()
   (logout)
   (work) )

(de choSup (Dst)
   (diaform '(Dst)
      (<grid> "-.--"
         ,"Name" (gui 'name '(+Focus +Var +TextField) '*SupNm 30)
         (searchButton '(init> (: home query)))
         (resetButton '(name)) )
      (gui 'query '(+QueryChart) (cho)
         '(goal
            (quote
               @Nm *SupNm
               (select (@@)
                  ((name +Supplier @Nm))
                     (tolr @Nm @@ name) ) ) )
         2
         '((This) (list This (: name)) ) )
      (<table> 'chart (choTtl ,"Suppliers" 'name '+Supplier)
         (quote
            (btn)
            (NIL ,"Name") )
         (do (cho)
            (<row> (alternating)
               (gui 1 '(+DstButton) Dst)
               (gui 2 '(+TextField)) ) ) )
      (<spread>
         (scroll (cho))
         (newButton T Dst '(+Supplier) 'name *SupNm)
         (cancelButton) ) ) )

(de choProd (Dst)
   (diaform '(Dst)
      (<grid> "-.-"
         ,"Category" (gui 'category '(+Var +TextField) '*ProdCat 30)
         (searchButton '(init> (: home query)))
         ,"Title" (gui 'title '(+Var +TextField) '*ProdTtl 30)
         (resetButton '(category title supplier query))
         ,"Supplier" (gui 'supplier '(+Var +TextField) '*ProdSup 30) )
      (gui 'query '(+QueryChart) (cho)
         '(goal
            (quote
               @Cat *ProdCat
               @Ttl *ProdTtl
               @Sup *ProdSup
               (select (@@)
                  ((category +Product @Cat)
                     (title +Product @Ttl)
                     (name +Supplier @Sup (supplier +Product)) )
                  (part @Cat @@ category)
                  (part @Ttl @@ title)
                  (tolr @Sup @@ supplier name) ) ) )
         4
         '((This) (list This (: category) (: title) (: supplier)) ) )
      (<table> 'chart (choTtl ,"Products" 'category '+Product)
         (quote
            (btn)
            (NIL ,"Category")
            (NIL ,"Title")
            (NIL ,"Supplier") )
         (do (cho)
            (<row> (alternating)
               (gui 1 '(+DstButton) Dst)
               (gui 2 '(+TextField))
               (gui 3 '(+TextField))
               (gui 4 '(+ObjView +TextField) '(: name)) ) ) )
      (<spread>
         (scroll (cho))
         (newButton T Dst '(+Product)
            'category *ProdCat
            'title *ProdTtl )
         (cancelButton) ) ) )

(de choEvt (Dst)
   (diaform '(Dst)
      (<grid> "-.-.-.-."
         ,"Date"       (gui 'date '(+Var +DateField)     '*EvtDat 10)
         ,"Event type" (gui 'tp '(+Var +Map +TextField)  '*EvtTp '((*Income . 1) (*Expense . 2)) '(*Income *Expense))
         ,"Title"      (gui 'product '(+Var +TextField)  '*EvtProd 10)
         ,"Quantity"   (gui 'quantity '(+Var +NumField)  '*EvtQt 10)
         ,"Sell price" (gui 'sellprice '(+Var +FixField) '*EvtSpr 2 10)
         ,"Buy price"  (gui 'buyprice '(+Var +FixField)  '*EvtBpr 2 10)
         (searchButton '(init> (: home query)))
         (resetButton '(date tp product quantity sellprice buyprice query)) )
      (gui 'query '(+QueryChart) (cho)
         '(goal
            (quote
               @Dt (and *EvtDat (cons @ T))
               @Tp *EvtTp
               @Prd *EvtProd
               @Qt (and *EvtQt (cons @ T))
               @Spr (and *EvtSpr (cons @ T))
               @Bpr (and *EvtBpr (cons @ T))
               (select (@@)
                  ((date +Event @Dt)
                     (tp +Event @Tp)
                     (title +Product @Prd (product +Event))
                     (quantity +Event @Qt)
                     (sellprice +Event @Spr)
                     (buyprice +Event @Bpr) )
                  (range @Dt @@ date)
                  (same @Tp @@ tp)
                  (tolr @Prd @@ product name)
                  (range @Qt @@ quantity)
                  (range @Spr @@ sellprice)
                  (range @Bpr @@ buyprice) ) ) )
         10
         '((This) (list This
                     (: date)
                     (utils::strTp (: tp))
                     (: product)
                     (: quantity)
                     (: sellprice)
                     (* (: sellprice) (: quantity)) (: buyprice)
                     (* (: buyprice) (: quantity))
                     (- (* (: sellprice) (: quantity)) (* (: buyprice) (: quantity))) ) ) )
      (<table> 'chart (choTtl ,"Event" 'date '+Event)
         (quote
            (btn)
            (NIL ,"Date")
            (NIL ,"Event type")
            (NIL ,"Title")
            (NIL ,"Quantity")
            (NIL ,"Sell price")
            (NIL ,"Sell sum")
            (NIL ,"Buy price")
            (NIL ,"Buy sum")
            (NIL ,"Charge") )
         (do (cho)
            (<row> (alternating)
               (gui 1  '(+DstButton) Dst)
               (gui 2  '(+DateField))
               (gui 3  '(+TextField))
               (gui 4  '(+ObjView +TextField) '(: title))
               (gui 5  '(+NumField))
               (gui 6  '(+FixField) 2)
               (gui 7  '(+FixField) 2)
               (gui 8  '(+FixField) 2)
               (gui 9  '(+FixField) 2)
               (gui 10 '(+FixField) 2) ) ) )
      (<spread>
         (scroll (cho))
            (newButton T Dst '(+Event)
               'date (date)
               'tp *EvTp) )
            (cancelButton) ) )


