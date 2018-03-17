
# Supplier
(class +Supplier +Entity)
(rel nr   (+Need +Key +Number))
(rel name (+Sn +IdxFold +String))

(dm url> (Tab) (and (may Supplier) (list "app/supplier.l"  '*ID This)) )

# Product
(class +Product +Entity)
(rel nr         (+Need +Key +Number))
(rel category   (+IdxFold +String))
(rel title      (+IdxFold +String))
(rel supplier   (+Ref +Link) NIL (+Supplier))

(dm url> (Tab) (and (may Product) (list "app/product.l" '*ID This)) )



# Income
(class +Income +Entity)
(rel nr        (+Need +Key +Number))
(rel date      (+Ref +Date))
(rel product   (+Ref +Link) NIL (+Product))
(rel quantity  (+Ref +Number))
(rel sellprice (+Ref +Number))
(rel buyprice  (+Ref +Number))

(dm url> (Tab) (and (may Income) (list "app/income.l" '*ID This)) )

# Expense
(class +Expense +Entity)
(rel nr        (+Need +Key +Number))
(rel date      (+Ref +Date))
(rel product   (+Ref +Link) NIL (+Product))
(rel quantity  (+Ref +Number))
(rel sellprice (+Ref +Number))
(rel buyprice  (+Ref +Number))

(dm url> (Tab) (and (may Expense) (list "app/expense.l" '*ID This)) )

# Database sizes
(dbs
   (3 +Role +User (+User pw))
   (1 +Product +Income +Expense)
   (2 +Supplier) )
