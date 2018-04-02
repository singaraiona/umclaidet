
### Color
(de rgba (R G B A)
   (text "rgba(@1,@2,@3,@4)" R G B A) )

### String repr
(de toStr (V)
   (if (str? V)
      (link (text "\"@1\"" V))
      (link V) ) )

### Inspired by standart json.l
(de jsDict (Item)
   (pack
      (make
         (cond
            ((atom Item) (if Item (toStr @) (link "{}")))
            ((=T (car Item))
               (link "[")
               (map
                  '((X)
                     (link (jsDict (car X)))
                     (and (cdr X) (link ", ")) )
                  (cdr Item) )
               (link "]") )
            (T
               (link "{")
               (map
                  '((X)
                     (link (caar X))
                     (link ": ")
                     (link (jsDict (cdar X)))
                     (and (cdr X) (link ", ")) )
                  Item )
               (link "}") ) ) ) ) )

(de clrs (L)
   (make
      (link "backgroundColor" T)
      (mapc
         '((X)
            (link (rgba (rand 0 255) (rand 0 255) (rand 0 255) 1)) )
         L ) ) )

### Chart.js data[] assemble macro
(de chData Args
   (let (Lbls (eval (pop 'Args))
         Dset (eval (pop 'Args))
         Clrs (eval (pop 'Args)) )
      (seed (time))
         (make
            (link
               (make
                  (link "labels" T)
                  (mapc link Lbls) ) )
            (link
               (make
                  (link "datasets" T)
                  (link
                     (make
                        (link
                           (make
                              (link "data" T)
                              (mapc link Dset) ) )
                              (link Clrs) ) ) ) ) ) ) )

### Pisolisp wrapper for https://www.chartjs.org/
(class +ChartJS +gui)

(dm js> ())
(dm put> () (msg "PUT"))

(dm T (Tp Wdth Hght UpLbls UpData)
   (=: id (text "_chart_@1_@2" (date) (time)))
   (=: tp Tp)
   (=: width Wdth)
   (=: height Hght)
   (=: uplbls UpLbls)
   (=: updata UpData)
   (super) )

(dm init> ()
   (=: labels (head 10 (eval (: uplbls))))
   (=: data (head 10 (eval (: updata))))
   (=: colors (clrs (: labels))) )

#(dm set> (L V)
#   (and L V
#     (=: labels L)
#     (=: colors (clrs L))
#     (=: data V)) )

(dm clr> ()
   (=: labels NIL)
   (=: data NIL)
   )

(dm show> ("Var")
   (prin "<script src=\"https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js\"></script>")
   (prin (text "<canvas id=\"@1\" width=\"@2\" height=\"@3\"></canvas>" (: id) (: width) (: height)))
   (prin (text
      "<script>new Chart(document.getElementById(\"@1\"),{type:'@2',data:@3,options:@4});</script>"
      (: id)
      (: tp)
      (jsDict (chData (: labels) (: data) (: colors)))
      (jsDict (: opts)) ) ) )
