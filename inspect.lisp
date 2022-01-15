(cl:in-package #:docleanser)

(define-docleanser-command (com-inspect-history :name t)
    ()
  (clouseau:inspect
   (clim:stream-output-history
    (clim:find-pane-named clim:*application-frame* 'image))))
