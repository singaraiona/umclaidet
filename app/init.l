
### Role ###
(obj ((+Role) nm "Administration") perm `*Perms)
(commit)

### User ###
(obj ((+User) nm "admin") pw `(passwd "admin") nam "Administrator" role `(db 'nm '+Role "Administration"))
(obj ((+User) nm "olyatoha") pw `(passwd "lozovaya") nam "Administrator" role `(db 'nm '+Role "Administration"))
(commit)

### Settings ###
(obj ((+Settings) getdate 1 events_autofill 1 currency_factor 100))
(commit)
