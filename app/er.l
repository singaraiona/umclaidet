
### Supplier
(class +Supplier +Entity)
(rel nr   (+Need +Key +Number))
(rel name (+Need +Sn +IdxFold +String))

(dm url> (Tab) (and (may Supplier) (list "app/supplier.l"  '*ID This)) )

(dm check> ()
   (make
      (or (: name) (link ,"No customer name")) ) )

### Product
(class +Product +Entity)
(rel nr         (+Need +Key +Number))
(rel category   (+Need +IdxFold +String))
(rel title      (+Need +IdxFold +String))
(rel supplier   (+Ref +Link) NIL (+Supplier))

(dm url> (Tab) (and (may Product) (list "app/product.l" '*ID This)) )

### Event
(class +Event +Entity)
(rel nr        (+Need +Key +Number))
(rel date      (+Ref +Date))
(rel tp        (+Ref +Number))
(rel product   (+Ref +Link) NIL (+Product))
(rel quantity  (+Ref +Number))
(rel sellprice (+Ref +Number))
(rel buyprice  (+Ref +Number))

(dm url> (Tab) (and (may Event) (list "app/event.l" '*ID This)) )

### Database sizes
(dbs
   (3 +Role +User (+User pw))
   (1 +Product +Event)
   (2 +Supplier) )
