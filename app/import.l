
(must "Import" Import)

(menu, "Import"
   (form "Import from CSV"
      (<hr>)
      (<tab>
         (,"Suppliers" (utils::upfile utils::suppliers))
         (,"Products"  (utils::upfile utils::products))
         (,"Events"    (utils::upfile utils::events)) )
      (<hr>) ) )
