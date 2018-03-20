(de import::strip (Ln)
   (pack (clip (chop Ln))) )

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

(de import::parsefile (Fl Clb)
   (in Fl
      (while (line)
         (Clb @) ) ) )

(de import::upfile Args
   (let Clb (pop 'Args)
      (gui '(+Tiny +UpField))
      (gui '(+Drop +Button)
         '(field -1)
         "Загрузить"
         (make
            (link 'when)
            (link '(: drop))
            (link (make
               (link 'ifn)
               (link (make
                  (link Clb)
                  (link '@) ) )
               (link (make
                  (link 'prog '(commit) '(init> (: home query))) ) )
               (link '(alert NIL "Ошибка импорта: неверный формат файла!" (<spread> (okButton))) ) ) ) ) ) ) )

(de import::suppliers (Fl)
   (import::parsefile Fl
      '((L) (import::obj ((+Supplier) name (import::strip L))) ) )
   NIL)
