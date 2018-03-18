
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
                     (T ,"Report"
                        (,"Remains" (and (may Report) "app/remains.l"))
                        (,"Selling" (and (may Report) "app/selling.l")) ) ) )
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
            (align "#")
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
         ,"Category" (gui 'category '(+Var +TextField) '*ProdCat 30)
         ,"Title" (gui 'title '(+Var +TextField) '*ProdTtl 30)
         ,"Supplier" (gui 'supplier '(+Var +TextField) '*ProdSup 30)
         (searchButton '(init> (: home query)))
         (resetButton '(nr category title supplier query)) )
      (gui 'query '(+QueryChart) (cho)
         '(goal
            (quote
               @Nr (and *ProdNr (cons @ T))
               @Cat *ProdCat
               @Ttl *ProdTtl
               @Sup *ProdSup
               (select (@@)
                  ((nr +Product @Nr)
                        (category +Product @Cat)
                        (title +Product @Ttl)
                        (name +Supplier @Sup
                              (supplier +Product)) )
                  (range @Nr @@ nr)
                  (part @Cat @@ category)
                  (part @Ttl @@ title)
                  (tolr @Sup @@ supplier name) ) ) )
         5
         '((This) (list This (: nr) This This (: supplier)) ) )
      (<table> 'chart (choTtl ,"Products" 'nr '+Product)
         (quote
            (btn)
            (align "#")
            (NIL ,"Category")
            (NIL ,"Title")
            (NIL ,"Supplier") )
         (do (cho)
            (<row> (alternating)
               (gui 1 '(+DstButton) Dst)
               (gui 2 '(+NumField))
               (gui 3 '(+ObjView +TextField) '(: category))
               (gui 4 '(+ObjView +TextField) '(: title))
               (gui 5 '(+ObjView +TextField) '(: name)) ) ) )
      (<spread>
         (scroll (cho))
         (newButton T Dst '(+Product)
            '(nr genKey 'nr '+Product)
            'category *ProdCat
            'title *ProdTtl )
         (cancelButton) ) ) )

(de choEvt (Dst)
   (diaform '(Dst)
      (<grid> "-.-.-.-."
         ,"Number"     (gui 'nr '(+Focus +Var +NumField) '*EvtNr 10)
         ,"Date"       (gui 'date '(+Var +DateField)     '*EvtDat 10)
         ,"Event type" (gui 'tp '(+Var +Map +TextField)  '*EvtTp '((*Income . 1) (*Expense . 2)) '(*Income *Expense))
         ,"Title"      (gui 'product '(+Var +TextField)  '*EvtProd 10)
         ,"Quantity"   (gui 'quantity '(+Var +NumField)  '*EvtQt 10)
         ,"Sell price" (gui 'sellprice '(+Var +FixField) '*EvtSpr 2 10)
         ,"Buy price"  (gui 'buyprice '(+Var +FixField)  '*EvtBpr 2 10)
         (searchButton '(init> (: home query)))
         (resetButton '(nr date tp product quantity sellprice buyprice query)) )
      (gui 'query '(+QueryChart) (cho)
         '(goal
            (quote
               @Nr (and *EvtNr (cons @ T))
               @Dt (and *EvtDat (cons @ T))
               @Tp *EvtTp
               @Prd *EvtProd
               @Qt (and *EvtQt (cons @ T))
               @Spr (and *EvtSpr (cons @ T))
               @Bpr (and *EvtBpr (cons @ T))
               (select (@@)
                  ((nr +Event @Nr)
                        (date +Event @Dt)
                        (tp +Event @Tp)
                        (title +Product @Prd (product +Event))
                        (quantity +Event @Qt)
                        (sellprice +Event @Spr)
                        (buyprice +Event @Bpr) )
                  (range @Nr @@ nr)                  
                  (range @Dt @@ date)
                  (same @Tp @@ tp)
                  (tolr @Prd @@ product name)
                  (range @Qt @@ quantity)
                  (range @Spr @@ sellprice)
                  (range @Bpr @@ buyprice) ) ) )
         11
         '((This) (list This (: nr) This This (: product) This This This This This This) ) )
      (<table> 'chart (choTtl ,"Event" 'nr '+Event)
         (quote
            (btn)
            (align "#")
            (NIL ,"Date")
            (NIL ,"Event type")
            (NIL ,"Product title")
            (NIL ,"Quantity")
            (NIL ,"Sell price")
            (NIL ,"Sell sum")
            (NIL ,"Buy price")
            (NIL ,"Buy sum")
            (NIL ,"Charge") )
         (do (cho)
            (<row> (alternating)
               (gui 1  '(+DstButton) Dst)
               (gui 2  '(+NumField))
               (gui 3  '(+ObjView +DateField) '(: date))
               (gui 4  '(+ObjView +TextField) '(strtp (: tp)))
               (gui 5  '(+ObjView +TextField) '(: title))
               (gui 6  '(+ObjView +NumField)  '(: quantity))
               (gui 7  '(+ObjView +FixField)  '(: sellprice) 2)
               (gui 8  '(+ObjView +FixField)  '(*(: sellprice) (: quantity)) 2)
               (gui 9  '(+ObjView +FixField)  '(: buyprice) 2)
               (gui 10  '(+ObjView +FixField) '(*(: buyprice) (: quantity)) 2)
               (gui 11 '(+ObjView +FixField)  '(- (*(: sellprice) (: quantity)) (*(: buyprice) (: quantity))) 2) ) ) )
      (<spread>
         (scroll (cho))
            (newButton T Dst '(+Event)
               '(nr genKey 'nr '+Event)
               'date (date) ) )
            (cancelButton) ) )

(de strtp(Tp)
   (if (= Tp 1) *Income *Expense) )