
# Supplier
(class +Supplier +Entity)
(rel nr   (+Need +Key +Number))          # Supplier Number
(rel name (+Sn +IdxFold +String))        # Name

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
(rel nr       (+Need +Key +Number)) # Number
(rel date     (+Need +Ref +Date))   # Date
(rel price    (+Ref +Number) NIL 2) # Price
(rel quantity (+Ref +Number) NIL 2) # Quantity

(dm url> (Tab)
   (and (may Admission) (list "app/admission.l" '*ID This)) )

(dm check> ()
   (make
      (or (: nr)     (link ,"Admission number"))
      (or (: date)   (link ,"Admission date")) ))


# Database sizes
(dbs
   (3 +Role +User (+User pw))              # 512 Prevalent objects
   (1 +Product +Admission)                 # B:128 Small objects
   (2 +Supplier) )                         # C:256 Normal objects
