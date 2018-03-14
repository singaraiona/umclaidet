
# Supplier
(class +Supplier +Entity)
(rel nr   (+Need +Key +Number))
(rel name (+Sn +IdxFold +String))

(dm url> (Tab) (and (may Supplier) (list "app/supplier.l"  '*ID This)) )

# Product
(class +Product +Entity)
(rel nr         (+Need +Key +Number))
(rel brand      (+IdxFold +String))
(rel name       (+IdxFold +String))
(rel supplier   (+Ref +Link) NIL (+Supplier))

(dm url> (Tab) (and (may Product) (list "app/product.l" '*ID This)) )

# Admission
(class +Admission +Entity)
(rel nr       (+Need +Key +Number))
(rel date     (+Ref +Date))
(rel product  (+Ref +Link) NIL (+Product))
(rel price    (+Ref +Number))
(rel quantity (+Ref +Number))

(dm url> (Tab) (and (may Admission) (list "app/admission.l" '*ID This)) )

# Database sizes
(dbs
   (3 +Role +User (+User pw))
   (1 +Product +Admission)
   (2 +Supplier) )
