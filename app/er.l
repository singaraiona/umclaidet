
# Supplier
(class +Supplier +Entity)
(rel nr   (+Need +Key +Number))
(rel name (+Sn +IdxFold +String))

(dm url> (Tab)
   (and (may Supplier) (list "app/supplier.l"  '*Tab Tab  '*ID This)) )

# Product
(class +Product +Entity)
(rel nr         (+Need +Key +Number))          # Item Number
(rel brand      (+IdxFold +String))            # Item Brand
(rel name       (+IdxFold +String))            # Item Name
(rel supplier   (+Ref +Link) NIL (+Supplier))  # Supplier

(dm url> (Tab)
   (and (may Product) (list "app/product.l" '*ID This)) )

(dm check> ()
   (make
      (or (: nr)     (link, "Product number"))
      (or (: brand)  (link, "Product brand"))
      (or (: name)   (link, "Product name")) ) )

# Admission
(class +Admission +Entity)
(rel nr       (+Need +Key +Number))
(rel date     (+Need +Ref +Date))
(rel price    (+Ref +Number) NIL 2)
(rel quantity (+Ref +Number) NIL 2)

(dm url> (Tab)
   (and (may Admission) (list "app/admission.l" '*ID This)) )

(dm check> ()
   (make
      (or (: nr)     (link ,"Admission number"))
      (or (: date)   (link ,"Admission date")) ))


# Database sizes
(dbs
   (3 +Role +User (+User pw))
   (1 +Product +Admission)
   (2 +Supplier) )
