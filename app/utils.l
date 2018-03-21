
(de utils::login ()
   (setq *Login (pilog
      (quote
         @Nm "admin"
         (select (@User)
            ((nm +User @Nm))
               (tolr @Nm @User nm) ) )
      @User) ) )

(de utils::strTp (Tp)
   (if (= Tp 1) *Income (if (= Tp 2) *Expense NIL) ) )

(de utils::tpStr (S)
   (if (= S *Income) 1 (if (= S *Expense) 2 NIL) ) )