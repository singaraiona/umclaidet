
# Supplier
(class +Supplier +Entity)
(rel number (+Need +Key +Number))          # Supplier Number
(rel name   (+Sn +IdxFold +String))        # Name

(dm url> (Tab)
   (and (may Supplier) (list "app/supplier.l"  '*Tab Tab  '*ID This)) )

# Product
(class +Product +Entity)
(rel number     (+Need +Key +Number))          # Item Number
(rel brand      (+IdxFold +String))            # Item Brand
(rel name       (+IdxFold +String))            # Item Name
(rel supplier   (+Ref +Link) NIL (+Supplier))  # Supplier

(dm url> (Tab)
   (and (may Product) (list "app/product.l" '*ID This)) )

(dm cnt> ()
   (-
      (or (: inv) 0)
      (sum '((This) (: cnt))
         (collect 'prd '+Pos This) ) ) )

(dm check> ()
   (make
      (or (: number) (link, "Не указан номер товара!"))
      (or (: brand)  (link, "Не указанa марка товара!"))
      (or (: name)   (link, "Не указано название товара!")) ) )


# Admission
(class +Admission +Entity)
(rel number   (+Need +Key +Number)) # Number
(rel date     (+Need +Ref +Date))   # Date
(rel price    (+Ref +Number) NIL 2) # Price
(rel quantity (+Ref +Number) NIL 2) # Quantity

(dm url> (Tab)
   (and (may Admission) (list "app/admission.l" '*ID This)) )

(dm check> ()
   (make
      (or (: number) (link ,"Не указан номер поступления!"))
      (or (: date)   (link ,"Не указана дата поступления!")) ))

;; # Database sizes
;; (dbs
;;    (3 +Role +User +Sal (+User pw))              # 512 Prevalent objects
;;    (0 +Supplier +Admission)                     # A:256 Normal objects
;;    (2 (+Role nm) (+User nm) (+Sal nm))          # D:256 Small indexes
;;    (4 (+CuSu nr plz tel mob))                   # E:1024 Normal indexes
;;    (4 (+CuSu nm))                               # F:1024
;;    (4 (+CuSu ort))                              # G:1024
;;    (4 (+Item nr sup pr))                        # H:1024
;;    (4 (+Item nm))                               # I:1024
;;    (4 (+Ord nr dat cus))                        # J:1024
;;    (4 (+Pos itm)) )                             # K:1024

# vi:et:ts=3:sw=3
