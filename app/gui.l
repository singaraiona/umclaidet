
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
                        (,"Suppliers" (and (may Supplier) "app/supplier.l"))
                        (,"Products" (and (may Product) "app/product.l"))
                        (,"Admissions" (and (may Admission) "app/admission.l")) )
                     (T ,"Report"
                        (,"Inventory" (and (may Report) "app/inventory.l")) ) ) )
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

(de choAdm (Dst)
   (diaform '(Dst)
      (<grid> "-.-.--"
         ,"Number"       (gui 'nr '(+Focus +Var +NumField) '*AdmNr 10)
         ,"Date"         (gui 'date '(+Var +DateField) '*AdmDat 10)
         ,"Product name" (gui 'product '(+Var +TextField) '*AdmProd 10)
         ,"Buy price"    (gui 'price '(+Var +FixField) '*AdmPr 2 10)
         ,"Quantity"     (gui 'quantity '(+Var +NumField) '*AdmQt 10)
         (searchButton '(init> (: home query)))
         (resetButton '(nr date product price quantity query)) )
      (gui 'query '(+QueryChart) (cho)
         '(goal
            (quote
               @Nr (and *AdmNr (cons @ T))
               # @Dt (cons (or *AdmDat T))
               @Dt (and *AdmDat (cons @ T))
               @Prd *AdmProd
               @Pr (and *AdmPr (cons @ T))
               @Qt (and *AdmQt (cons @ T))
               (select (@@)
                  ((nr +Admission @Nr)
                        (date +Admission @Dt)
                        (name +Product @Prd (product +Admission))
                        (price +Admission @Pr)
                        (quantity +Admission @Qt) )
                  (range @Nr @@ nr)
                  (range @Dt @@ date)
                  (tolr @Prd @@ product name)
                  (range @Pr @@ price)
                  (range @Qt @@ quantity) ) ) )
         6
         '((This) (list This (: nr) This (: product) This This) ) )
      (<table> 'chart (choTtl ,"Products" 'nr '+Product)
         (quote
            (btn)
            (align "#")
            (NIL ,"Date")
            (NIL ,"Product")
            (NIL ,"Price")
            (NIL ,"Quantity") )
         (do (cho)
            (<row> (alternating)
               (gui 1 '(+DstButton) Dst)
               (gui 2 '(+NumField))
               (gui 3 '(+ObjView +DateField) '(: date))
               (gui 4 '(+ObjView +TextField) '(: name))
               (gui 5 '(+ObjView +FixField)  '(: price) 2)
               (gui 6 '(+ObjView +NumField)  '(: quantity)) ) ) )
      (<spread>
         (scroll (cho))
         (newButton T Dst '(+Admission)
            '(nr genKey 'nr '+Admission)
            'date (date) )
         (cancelButton) ) ) )