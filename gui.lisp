(cl:in-package #:docleanser)

(clim:define-application-frame docleanser ()
  ((%image :initarg :image :reader image)
   (%transformation
    :initform (clim:make-scaling-transformation* 0.4 0.4)
    :accessor transformation))
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
  (let* ((transformation (transformation frame))
         (pattern (clim:transform-region transformation (image frame))))
    (clim:draw-pattern* pane pattern 0 0)))

(defun docleanser (filename)
  (clim:run-frame-top-level
   (clim:make-application-frame 'docleanser
     :image (clim:make-pattern-from-bitmap-file filename))))
