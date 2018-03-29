
### Create Chart
(de draw::chart (Id W H)
   (javascript "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/1.0.2/Chart.min.js")
   (prin (text "<canvas id=\"@1\" width=\"@2\" height=\"@3\"></canvas>" Id W H)) )

###
(de rgba (R G B A)
   (text "rgba(@1,@2,@3,@4)" R G B A) )

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

###
(de draw::display (Id Data . Opts)
   (text "var data=@1;@2;@3;@4;"
      (draw::dict Data)
      (text "var ctx = document.getElementById(\"@1\").getContext(\"2d\")" Id)
      "var lineChart = new Chart(ctx).Line(data, {})"
      "return false" ) )
