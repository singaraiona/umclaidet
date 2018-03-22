
(must "Import" Import)

(menu, "Import"
   (form "Import from CSV"
      (<hr>)
      (<tab>
         (,"Suppliers" (utils::upfile utils::usups))
         (,"Products"  (utils::upfile utils::uprods))
         (,"Events"    (utils::upfile utils::uevts)) )
      (<hr>) ) )
