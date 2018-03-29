
### Create Chart
(de draw::chart (Id W H)
   (javascript "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js")
   (prin (text "<canvas id=\"@1\" width=\"@2\" height=\"@3\"></canvas>" Id W H)) )

### Color
(de rgba (R G B A)
   (text "rgba(@1,@2,@3,@4)" R G B A) )

### String repr
(de tostr (V)
   (if (str? V)
      (link (text "\"@1\"" V))
      (link V) ) )

### Inspired by standart json.l
(de draw::dict (Item)
   (pack
      (make
         (cond
            ((atom Item) (if Item (tostr @) (link "{}")))
            ((=T (car Item))
               (link "[")
               (map
                  '((X)
                     (link (draw::dict (car X)))
                     (and (cdr X) (link ", ")) )
                  (cdr Item) )
               (link "]") )
            (T
               (link "{")
               (map
                  '((X)
                     (link (caar X))
                     (link ": ")
                     (link (draw::dict (cdar X)))
                     (and (cdr X) (link ", ")) )
                  Item )
               (link "}") ) ) ) ) )

### Show Chart
(de draw::display (Id Tp Dt . Ops)
   (text
      "new Chart(document.getElementById(\"@1\"),
      {type:'@2',data:@3,options:@4});return false;"
      Id Tp
      (draw::dict Dt)
      (draw::dict Ops) ) )
