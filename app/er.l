
### Supplier
(class +Supplier +Entity)
(rel nr   (+Need +Key +Number))
(rel name (+Need +Sn +IdxFold +String))

(dm url> (Tab) (and (may Supplier) (list "app/supplier.l" '*ID This)) )

### Category
(class +Category +Entity)
(rel nr   (+Need +Key +Number))
(rel name (+Need +Sn +IdxFold +String))
(rel products (+List +Joint) category (+Product))

(dm url> (Tab) (and (may Category) (list "app/category.l" '*ID This)) )

### Product
(class +Product +Entity)
(rel nr         (+Need +Key +Number))
(rel category   (+Joint) products (+Category))
(rel title      (+Sn +IdxFold +String))
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
(rel notes     (+Sn +IdxFold +String))

(dm url> (Tab) (and (may Event) (list "app/event.l" '*ID This)) )

### Settings
(class +Settings +Entity)
(rel getdate (+Ref +Number)) # Autofill Date in new event (1 - current 2 - last)
(rel events_autofill (+Ref +Number))
(rel currency_factor (+Ref +Number))

### Database sizes
(dbs
   (3 +Role +User (+User pw))
   (1 +Category +Product +Event)
   (2 +Supplier)
   (2 +Settings) )
