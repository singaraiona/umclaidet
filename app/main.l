
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

(locale "RU" "ru" "app/loc/")

(load "app/er.l" "app/lib.l" "app/gui.l")

(permission
   Product     ,"Product"
   Supplier    ,"Supplier"
   Income      ,"Income"
   Expense     ,"Expense"
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
      (load "app/init.l") ) (mm))

(de mm()
   (prinl (incme (1 . 4)))
)


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
