(cl:in-package #:asdf-user)

(defsystem #:docleanser
  :depends-on (#:mcclim #:clouseau)
  :serial t
  :components
  ((:file "packages")
   (:file "gui")
   (:file "crop")))
