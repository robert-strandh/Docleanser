(cl:in-package #:asdf-user)

(defsystem #:docleanser
  :depends-on (#:mcclim #:clouseau)
  :serial t
  :components
  ((:file "packages")
   (:file "pixmap-output-record")
   (:file "gui")
   (:file "inspect")
   (:file "crop")))
