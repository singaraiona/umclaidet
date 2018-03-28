
### Create Chart
(de draw::chart (Id W H)
   (javascript "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/1.0.2/Chart.min.js")
   (prin (text "<canvas id=\"@1\" width=\"@2\" height=\"@3\"></canvas>" Id W H)) )

### 
(de rgba (R G B A)
   (text "rgba(@1,@2,@3,@4)" R G B A) )

### Data set
(class +DSet)

(dm T (Lbl FillColor StrokeColor 
       PointColor PointStrokeColor
       PointHighlightFill PointHighlightStroke
       Data)
   (=: label Lbl)
   (=: fillColor FillColor)   
   (=: strokeColor StrokeColor)        
   (=: pointColor PointColor)        
   (=: pointStrokeColor PointStrokeColor)        
   (=: pointHighlightFill PointHighlightFill)        
   (=: pointHighlightStroke PointHighlightStroke)        
   (=: data Data) )

(dm display> ()
   (text 
      "{
         label: \"@1\",
         fillColor: \"@2\",
         strokeColor: \"@3\",
         pointColor: \"@4\",
         pointStrokeColor: \"@5\",
         pointHighlightFill: \"@6\",
         pointHighlightStroke: \"@7\",
         data: [@8] 
       }"
       (: label)
       (: fillColor)
       (: strokeColor)
       (: pointColor)
       (: pointStrokeColor)
       (: pointHighlightFill)
       (: pointHighlightStroke)
       (glue "," (: data)) ) )

(de draw::display (Id Lbls DSets . Opts)
   (pack
      (text 
         "var data = { labels: [@1]," 
         (glue "," (make (mapc '((X) (link (pack "\"" X "\""))) Lbls))) )
      "datasets: ["
      (glue "," (make (mapc '((X) (link (display> X))) DSets)))
      "]};"
      (text 
         "var ctx = document.getElementById(\"@1\").getContext(\"2d\");"
         Id )
      # TODO: Options
      (text "var options = {};")
      "var lineChart = new Chart(ctx).Line(data, options); return false;" ) )

(de pset ()
  (new '(+DSet) "MyDs" "rgba(151,187,205,0.2)"
              "rgba(151,187,205,1)" "rgba(151,187,205,1)"
              "#fff" "#fff" "rgba(151,187,205,1)" 
              '(0 1 1 2 3 5 8 13 21 34) ) )