
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

(de import::supplier (Ln)
   (import::obj ((+Supplier) name (pack Ln))) )

(de import::all (Path)
   (import::parsefile (pack Path "suppliers.csv") import::supplier)
   (commit) )