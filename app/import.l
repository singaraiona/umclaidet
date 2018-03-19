
(de import::obj Lst
   (let (ReqLst (pop 'Lst)
         ReqCls (pop 'ReqLst)
         l1 (make (link ReqCls)
                  (while ReqLst
                     (link (pop 'ReqLst))
                     (link (eval (pop 'ReqLst))) ) )
         Obj (apply request l1) )
   (while Lst
      (put> Obj (pop 'Lst) (eval (pop 'Lst))) )
   Obj) )

(de import::parsefile (File Clb)
   (in File
      (while (line)
         (Clb @) ) ) )

(setq *Gnr 1)

(de import::supplier (L)
   (match '(@Nm) L)
   (import::obj ((+Supplier) nr (inc '*Gnr)) name @Nm) )

(de import::all (Path)
   (import::parsefile (pack Path "suppliers.csv") import::supplier)
   (commit) )