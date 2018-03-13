
# Supplier
(class +Supplier +Entity)
(rel nr   (+Need +Key +Number))
(rel name (+Sn +IdxFold +String))

(dm url> (Tab)
   (and (may Supplier) (list "app/supplier.l"  '*Tab Tab  '*ID This)) )

# Product
(class +Product +Entity)
(rel nr         (+Need +Key +Number))
(rel brand      (+IdxFold +String))
(rel name       (+IdxFold +String))
(rel supplier   (+Ref +Link) NIL (+Supplier))

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
(rel product  (+Ref +Link) NIL (+Product))
(rel price    (+Ref +Number) NIL 2)
(rel quantity (+Ref +Number) NIL 2)

(dm url> (Tab)
   (and (may Admission) (list "app/admission.l" '*ID This)) )

(dm check> ()
   (make
      (or (: nr)       (link ,"Admission number"))
      (or (: date)     (link ,"Admission date"))
      (or (: product)  (link ,"Admission product"))
      (or (: price)    (link ,"Admission price"))
      (or (: quantity) (link ,"Admission quantity"))  ) )


# Database sizes
(dbs
   (3 +Role +User (+User pw))
   (1 +Product +Admission)
   (2 +Supplier) )
