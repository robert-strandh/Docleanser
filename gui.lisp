(cl:in-package #:docleanser)

(clim:define-application-frame docleanser ()
  ((%image :initarg :image :reader image))
  (:panes
   (image :application
          :scroll-bars nil
          :height 1000
          :width 1500
          :display-function 'display-image)
   (inter :interactor :width 1500 :height 100))
  (:layouts
   (:default (clim:vertically ()
               (clim:scrolling (:scroll-bars t :height 1000) image)
	       inter))))

(defun display-image (frame pane)
  (clim:draw-pattern* pane (image frame) 0 0))

(defun docleanser (filename)
  (clim:run-frame-top-level
   (clim:make-application-frame 'docleanser
     :image (clim:make-pattern-from-bitmap-file filename))))
