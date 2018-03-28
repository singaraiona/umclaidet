###
(de draw::chart (Id W H)
   (javascript
      "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/1.0.2/Chart.min.js"
      (in *ChartJs (till NIL T)) )
   (prin (text "<canvas id=\"@1\" width=\"@2\" height=\"@3\"></canvas>" Id W H)) )

(de draw::display (Id)
   "displayLineChart();
    return false;" )