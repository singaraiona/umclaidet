
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
                        (,"Categories" (and (may Category) "app/category.l"))
                        (,"Products" (and (may Product) "app/product.l")) )
                     (NIL (<hr>))
                     (T ,"Registration"
                        (,"Events" (and (may Event) "app/event.l")) )
                     (NIL (<hr>))
                     (T ,"Import"
                        (,"Import from CSV" (and (may Import) "app/import.l")) )
                     (NIL (<hr>))
                     (T ,"Report"
                        (,"Remains"  (and (may Report) "app/remains.l"))
                        (,"Analytic" (and (may Report) "app/analytic.l"))
                        (,"Charts"   (and (may Chart)  "app/chart.l")) ) ) )
               ((NIL NIL 'main)
                  (<div> @ (run Prg 1)) ) ) ) ) ) )

(de work ()
   (setq *Url "!work")
   (and (app) (setq *Menu 63))
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
      (<grid> "-.-"
         ,"Number" (gui 'nr '(+Var +NumField) '*SupNr 10)
         (searchButton '(init> (: home query)))
         ,"Name" (gui 'name '(+Focus +Var +TextField) '*SupNm 30)
         (resetButton '(nr name)) )
      (gui 'query '(+QueryChart) (cho)
         '(goal
            (quote
               @Nr (and *SupNr (cons @ T))
               @Nm *SupNm
               (select (@@)
                  ((nr +Supplier @Nr) (name +Supplier @Nm))
                     (range @Nr @@ nr)
                     (tolr @Nm @@ name) ) ) )
         3
         '((This) (list This (: nr) (: name)) ) )
      (<table> 'chart (choTtl ,"Suppliers" 'nr '+Supplier)
         (quote
            (btn)
            (align, "#")
            (NIL ,"Name") )
         (do (cho)
            (<row> (alternating)
               (gui 1 '(+DstButton) Dst)
               (gui 2 '(+NumField))
               (gui 3 '(+TextField)) ) ) )
      (<spread>
         (scroll (cho))
         (newButton T Dst '(+Supplier)
            '(nr genKey 'nr '+Supplier)
            'name *SupNm)
         (cancelButton) ) ) )

(de choCat (Dst)
   (diaform '(Dst)
      (<grid> "-.-"
         ,"Code" (gui 'nr '(+Var +NumField) '*CatNr 10)
         (searchButton '(init> (: home query)))
         ,"Name" (gui 'name '(+Focus +Var +TextField) '*CatNm 30)
         (resetButton '(nr name)) )
      (gui 'query '(+QueryChart) (cho)
         '(goal
            (quote
               @Nr (and *CatNr (cons @ T))
               @Nm *CatNm
               (select (@@)
                  ((nr +Category @Nr) (name +Category @Nm))
                     (range @Nr @@ nr)
                     (tolr @Nm @@ name) ) ) )
         3
         '((This) (list This (: nr) (: name)) ) )
      (<table> 'chart (choTtl ,"Categories" 'nr '+Category)
         (quote
            (btn)
            (align, "Code")
            (NIL ,"Name") )
         (do (cho)
            (<row> (alternating)
               (gui 1 '(+DstButton) Dst)
               (gui 2 '(+NumField))
               (gui 3 '(+TextField)) ) ) )
      (<spread>
         (scroll (cho))
         (newButton T Dst '(+Category)
            'nr (utils::catkey)
            'name *SupNm)
         (cancelButton) ) ) )

(de choProd (Dst)
   (diaform '(Dst)
      (<grid> "---"
         ,"Code" (gui 'nr '(+Var +NumField) '*ProdNr 10)
         (searchButton '(init> (: home query)))
         ,"Category" (gui 'category '(+Var +TextField) '*ProdCat 30)
         (resetButton '(nr category title supplier query))
         ,"Title" (gui 'title '(+Var +TextField) '*ProdTtl 30)
         (gui '(+Button) *Pdf '(url (print::products (solve (gui::products) @@))))
         ,"Supplier" (gui 'supplier '(+Var +TextField) '*ProdSup 30)
         NIL )
      (gui 'query '(+QueryChart) (cho)
         '(goal (gui::products))
         5
         '((This) (list This (: nr) (: category) (: title) (: supplier)) ) )
      (<table> 'chart (choTtl ,"Products" 'nr '+Product)
         (quote
            (btn)
            (align ,"Code")
            (NIL   ,"Category")
            (NIL   ,"Title")
            (NIL   ,"Supplier") )
         (do (cho)
            (<row> (alternating)
               (gui 1 '(+DstButton) Dst)
               (gui 2 '(+NumField))
               (gui 3 '(+ObjView +TextField) '(: name))
               (gui 4 '(+TextField))
               (gui 5 '(+ObjView +TextField) '(: name)) ) ) )
      (<spread>
         (scroll (cho))
         (newButton T Dst '(+Product)
            'nr (utils::prodkey (val> (: home category)))
            'title *ProdTtl )
         (cancelButton) ) ) )

(de choEvt (Dst)
   (diaform '(Dst)
      (<grid> "--.-..-"
         ,"Number"     (gui 'nr '(+Var +NumField) '*EvtNr 10)
         ,"Date"       (gui 'date '(+Var +DateField)     '*EvtDat 10)
         ,"Event type" (gui 'tp '(+Var +Map +TextField)  '*EvtTp '((*Income . 1) (*Expense . 2)) '(*Income *Expense))
         (searchButton '(init> (: home query)))
         ,"Title"      (gui 'product '(+Var +TextField)  '*EvtProd 10)
         ,"Quantity"   (gui 'quantity '(+Var +FixField)  '*EvtQt 2 10)
         ,"Sell price" (gui 'sellprice '(+Var +FixField) '*EvtSpr 2 10)
         (resetButton '(nr date tp product quantity sellprice buyprice notes query))
         ,"Buy price"  (gui 'buyprice '(+Var +FixField)  '*EvtBpr 2 10)
         ,"Notes"      (gui 'notes '(+Var +TextField)    '*EvtNts 10)
         NIL NIL
         (gui '(+Button) *Pdf '(url (print::events (solve (gui::events) @@) (val> (: home tp))))) )
      (gui 'query '(+QueryChart) (cho)
         '(goal (gui::events))
         12
         '((This) (list This
                     (: nr)
                     (: date)
                     (utils::strTp (: tp))
                     (: product)
                     (: quantity)
                     (: sellprice)
                     (/ (* (: sellprice) (: quantity)) 100)
                     (: buyprice)
                     (/ (* (: buyprice) (: quantity)) 100)
                     (/ (- (* (: sellprice) (: quantity)) (* (: buyprice) (: quantity))) 100)
                     (: notes) ) ) )
      (<table> 'chart (choTtl ,"Events" 'nr '+Event)
         (quote
            (btn)
            (align, "#")
            (NIL ,"Date")
            (NIL ,"Event type")
            (NIL ,"Title")
            (NIL ,"Quantity")
            (NIL ,"Sell price")
            (NIL ,"Sell sum")
            (NIL ,"Buy price")
            (NIL ,"Buy sum")
            (NIL ,"Charge")
            (NIL ,"Notes") )
         (do (cho)
            (<row> (alternating)
               (gui 1  '(+DstButton) Dst)
               (gui 2  '(+NumField))
               (gui 3  '(+DateField))
               (gui 4  '(+TextField))
               (gui 5  '(+ObjView +TextField) '(: title))
               (gui 6  '(+FixField) 2)
               (gui 7  '(+FixField) 2)
               (gui 8  '(+FixField) 2)
               (gui 9  '(+FixField) 2)
               (gui 10 '(+FixField) 2)
               (gui 11 '(+FixField) 2)
               (gui 12 '(+TextField)) ) ) )
      (<spread>
         (scroll (cho))
            (newButton T Dst '(+Event)
               '(nr genKey 'nr '+Event)
               'date (date)
               'tp *EvTp) )
            (cancelButton) ) )

### -- Retrieve
(de gui::products ()
   (quote
      @Nr  (and *ProdNr (cons @ T))
      @Cat *ProdCat
      @Ttl *ProdTtl
      @Sup *ProdSup
      (select (@@)
         ((nr +Product @Nr)
            (category +Category @Cat)
            (title +Product @Ttl)
            (supplier +Supplier @Sup) )
         (range @Nr @@ nr)
         (tolr  @Cat @@ category name)
         (part  @Ttl @@ title)
         (tolr  @Sup @@ supplier sname) ) ) )

(de gui::events ()
   (quote
      @Nr (and *EvtNr (cons @ T))
      @Dt (and *EvtDat (cons @ T))
      @Tp *EvtTp
      @Prd *EvtProd
      @Qt (and *EvtQt (cons @ T))
      @Spr (and *EvtSpr (cons @ T))
      @Bpr (and *EvtBpr (cons @ T))
      @Nts *EvtNts
      (select (@@)
         ((nr +Event @Nr)
            (date +Event @Dt)
            (tp +Event @Tp)
            (title +Product @Prd (product +Event))
            (quantity +Event @Qt)
            (sellprice +Event @Spr)
            (buyprice +Event @Bpr)
            (notes +Event @Nts) )
         (range @Nr @@ nr)
         (range @Dt @@ date)
         (same @Tp @@ tp)
         (tolr @Prd @@ product title)
         (range @Qt @@ quantity)
         (range @Spr @@ sellprice)
         (range @Bpr @@ buyprice)
         (tolr @Nts @@ notes) ) ) )

(de choChart (Dst)
   (diaform '(Dst)
      (<tab>
         (,"Remains"
            (<grid> "---"
               ,"Number" (gui 'nr '(+Var +NumField) '*SupNr 20)
               (searchButton '(init> (: home query)))
               ,"Name" (gui 'name '(+Focus +Var +TextField) '*SupNm 20)
               (resetButton '(nr name))
               NIL NIL
               (gui '(+OnClick +Button)
                  (draw::display
                     "RemainsChart"
                     '((labels T "Red" "Blue" "Yellow" "Green" "Purple" "Orange")
                        (datasets T
                           ((label . "Votes")
                             (data T 1 2 3 98 2 1)
                             (backgroundColor T
                                "rgba(255, 99, 132, 0.2)"
                                "rgba(54, 162, 235, 0.2)"
                                "rgba(255, 206, 86, 0.2)"
                                "rgba(75, 192, 192, 0.2)"
                                "rgba(153, 102, 255, 0.2)"
                                "rgba(255, 159, 64, 0.2)" ) ) ) ) )
                  "Показать") )
               (draw::chart "RemainsChart" 1024 768) )
          ) ) )
