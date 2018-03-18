
(allowed ("app/" "img/")
   "!work" "!stop" "@lib.css" "!psh" )

(scl 2)
(load
   "@lib/http.l" "@lib/xhtml.l" "@lib/form.l" "@lib/svg.l"
   "@lib/adm.l" )  # "@lib/boss.l"

(setq
   *Css '("@lib.css" "app/menu.css")
   *Pool "db/app/"
   *Blob "db/app/blob/"
   *Salt (16 . "$6$@1$") )

(setq *ProjectTitle "Магазин")
(setq *Income "Приход")
(setq *Expense "Расход")

(locale "RU" "ru" "app/loc/")

(load "app/er.l" "app/lib.l" "app/gui.l")

(permission
   Product     ,"Product"
   Supplier    ,"Supplier"
   Event       ,"Event"
   Report      ,"Report"
   RoleAdmin   ,"Role Administration"
   UserAdmin   ,"User Administration"
   Password    ,"Password"
   Delete      ,"Delete" )

# Entry point
(de main ()
   (call "mkdir" "-p" "db/app/" *Blob)
   (pool *Pool *Dbs)
   (unless (seq *DB)
      (load "app/init.l") )
      (lgn)
   (mapc foldgrp (by '((I) (; I product)) group (events))) )

(de foldgrp(Grp)
   (let Qty 0     
     (mapc '((Rec) (with Rec (inc 'Qty (: quantity)))) Grp)
     (msg "QTY: " Qty) )
)

(de lgn()
(setq *Login (pilog
         (quote
           @Nm "admin"
           (select (@User)
              ((nm +User @Nm))
                 (tolr @Nm @User nm)
                 ) )
      @User) )
)

(de events()
   (solve
      (quote
         @RngDt (0 . 45643568)
            (select (@Event)
               ((date +Event @RngDt))
                  (range @RngDt @Event date) ) )
      @Event) )

(de go (Rpc)
   (when Rpc
      (task (port @)  # Set up query server in the background
         (let? Sock (accept @)
            (unless (fork)  # Child process
               (in Sock
                  (while (rd)
                     (sync)
                     (tell)
                     (out Sock
                        (pr (eval @)) ) ) )
               (bye) )
            (close Sock) ) )
      (forked) )
   (rollback)
   (retire 20)
   (server (or (format (sys "PORT")) 8080) "!work") )
