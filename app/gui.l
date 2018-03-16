
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
                     (T ,"Events"
                        (,"Income" (and (may Income) "app/income.l"))
                        (,"Expense" (and (may Expense) "app/expense.l")) )
                     (NIL (<hr>))
                     (T ,"Report"
                        (,"Inventory" (and (may Report) "app/inventory.l")) ) ) )
               ((NIL NIL 'main)
                  (<div> @ (run Prg 1)) ) ) ) ) ) )

(de work ()
   (setq *Url "!work")
   (and (app) (setq *Menu 15))
   (menu "Магазин"
      (<h2> NIL "Магазин")
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

(de choInc (Dst)
   (diaform '(Dst)
      (<grid> "-.-.-.-."
         ,"Number"     (gui 'nr '(+Focus +Var +NumField) '*IncNr 10)
         ,"Date"       (gui 'date '(+Var +DateField) '*IncDat 10)
         ,"Title"      (gui 'product '(+Var +TextField) '*IncProd 10)
         ,"Quantity"   (gui 'quantity '(+Var +NumField) '*IncQt 10)
         ,"Sell price" (gui 'sellprice '(+Var +FixField) '*IncSpr 2 10)
         ,"Buy price"  (gui 'buyprice '(+Var +FixField) '*IncBpr 2 10)
         (searchButton '(init> (: home query)))
         (resetButton '(nr date product quantity sellprice buyprice query))
         )
      (gui 'query '(+QueryChart) (cho)
         '(goal
            (quote
               @Nr (and *IncNr (cons @ T))
               @Dt (and *IncDat (cons @ T))
               @Prd *IncProd
               @Qt (and *IncQt (cons @ T))
               @Spr (and *IncSpr (cons @ T))
               @Bpr (and *IncBpr (cons @ T))
               (select (@@)
                  ((nr +Income @Nr)
                        (date +Income @Dt)
                        (title +Product @Prd (product +Income))
                        (quantity +Income @Qt)
                        (sellprice +Income @Spr)
                        (buyprice +Income @Bpr) )
                  (range @Nr @@ nr)
                  (range @Dt @@ date)
                  (tolr @Prd @@ product name)
                  (range @Qt @@ quantity)
                  (range @Spr @@ sellprice)
                  (range @Bpr @@ buyprice) ) ) )
         10
         '((This) (list This (: nr) This (: product) This This This This This This) ) )
      (<table> 'chart (choTtl ,"Income" 'nr '+Income)
         (quote
            (btn)
            (align "#")
            (NIL ,"Date")
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
               (gui 4  '(+ObjView +TextField) '(: title))
               (gui 5  '(+ObjView +NumField)  '(: quantity))
               (gui 6  '(+ObjView +FixField)  '(: sellprice) 2)
               (gui 7  '(+ObjView +FixField)  '(*(: sellprice) (: quantity)) 2)
               (gui 8  '(+ObjView +FixField)  '(: buyprice) 2)
               (gui 9  '(+ObjView +FixField)  '(*(: buyprice) (: quantity)) 2)
               (gui 10 '(+ObjView +FixField)  '(- (*(: sellprice) (: quantity)) (*(: buyprice) (: quantity))) 2) ) ) )
      (<spread>
         (scroll (cho))
            (newButton T Dst '(+Income)
               '(nr genKey 'nr '+Income)
               'date (date) ) )
            (cancelButton) ) )