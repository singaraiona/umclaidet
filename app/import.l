(de customer::import(F)
   (in F
      (prinl (line) "\t" "SUM")
      (while (split (line) "\t")
      (prinl (glue "," @) "," (sum format @)) ) ) )