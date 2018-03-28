###
(de draw::chart (Id W H)
   (javascript
      "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/1.0.2/Chart.min.js")
      #(in *ChartJs (till NIL T)) )
   (prin (text "<canvas id=\"@1\" width=\"@2\" height=\"@3\"></canvas>" Id W H)) )

(de draw::display1 (Id Lbls)
   (text
      "var ctx = document.getElementById(\"@1\").getContext(\"2d\");
       var chart = new Chart(ctx, {
          type: \"bar\",
          data: {
              labels: [\"January\", \"February\", \"March\", \"April\", \"May\", \"June\", \"July\"],
              datasets: [{
                  label: \"My First dataset\",
                  backgroundColor: \"rgb(255, 99, 132)\",
                  borderColor: \"rgb(255, 99, 132)\",
                  data: [0, 10, 5, 2, 20, 30, 45],
              }]
          },
          options: {}
       });
       return false;"
      Id
      (glue "," Lbls) ) )

(de draw::display (Id Lbls)
   (text
      "var data = {
         labels: [@1],
         datasets: [{
            label: \"Prime and Fibonacci\",
            fillColor: \"rgba(220,220,220,0.2)\",
            strokeColor: \"rgba(220,220,220,1)\",
            pointColor: \"rgba(220,220,220,1)\",
            pointStrokeColor: \"#fff\",
            pointHighlightFill: \"#fff\",
            pointHighlightStroke: \"rgba(220,220,220,1)\",
            data: [2, 3, 5, 7, 11, 13, 17, 19, 23, 29] },

            { label: \"My Second dataset\",
            fillColor: \"rgba(151,187,205,0.2)\",
            strokeColor: \"rgba(151,187,205,1)\",
            pointColor: \"rgba(151,187,205,1)\",
            pointStrokeColor: \"#fff\",
            pointHighlightFill: \"#fff\",
            pointHighlightStroke: \"rgba(151,187,205,1)\",
            data: [0, 1, 1, 2, 3, 5, 8, 13, 21, 34] }]
         };
         var ctx = document.getElementById(\"@2\").getContext(\"2d\");
         var options = {};
         var lineChart = new Chart(ctx).Line(data, options);
         return false;"

      (glue "," (make (mapc '((X) (link (pack "\"" X "\""))) Lbls)))
      Id ) )