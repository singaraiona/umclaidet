
(allowed ("app/" "img/")
   "!work" "!stop" "@lib.css" "!psh" )

(scl 2)
(load "@lib/http.l" "@lib/xhtml.l" "@lib/form.l" "@lib/svg.l" "@lib/adm.l" )

(setq
   *Css '("@lib.css" "app/menu.css")
   *Pool "db/app/"
   *Blob "db/app/blob/"
   *Salt (16 . "$6$@1$") )

(setq *ProjectTitle "Магазин")
(setq *Income "Приход")
(setq *Expense "Расход")
(setq *ObjQty "Количество объектов: ")

(locale "RU" "ru" "app/loc/")

(load "app/er.l" "app/lib.l" "app/gui.l" "app/utils.l")

(permission
   Product     ,"Product"
   Supplier    ,"Supplier"
   Event       ,"Event"
   Report      ,"Report"
   Import      ,"Import"
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
      (utils::login) )

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
