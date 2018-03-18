(de lastnr(Obj)
   (apply max
      (solve
         (quote
            @Rng '(NIL . T)
               (select (@@)
                  ((nr Obj @Rng))
                     (range @Rng @@ nr) ) )
         (with @@ (: nr)) ) ) )

(de import::supplier(F)
   (in F
      (while (split (line) ",")
         (let (Nm (text @)
               Nr (genKey 'nr '+Supplier) )
            (msg Nr Nm)   
            (obj ((+Supplier) nr Nr name Nm))
            (commit) ) ) ) )