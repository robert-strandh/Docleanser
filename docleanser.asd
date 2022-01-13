(cl:in-package #:asdf-user)

(defsystem #:docleanser
  :depends-on (#:mcclim)
  :serial t
  :components
  ((:file "packages")
   (:file "read")
   (:file "crop")))
