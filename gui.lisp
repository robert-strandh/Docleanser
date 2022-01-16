(cl:in-package #:docleanser)

(clim:define-application-frame docleanser ()
  ((%image :initarg :image :reader image)
   (%transformation
    :initform (clim:make-scaling-transformation* 4/10 4/10)
    :accessor transformation))
  (:panes
   (image :application
          :scroll-bars nil
          :height 2000
          :width 1500
          :display-function 'display-image)
   (inter :interactor :width 1500 :height 100))
  (:layouts
   (:default (clim:vertically ()
               (clim:scrolling (:scroll-bars t :height 1000) image)
	       inter))))

(defun display-image (frame pane)
  (let* ((transformation (transformation frame))
         (pattern (clim:transform-region transformation (image frame)))
         (history (clim:stream-output-history pane)))
    (multiple-value-bind (min-x min-y max-x max-y)
        (clim:bounding-rectangle* pattern)
      (declare (ignore min-x min-y))
      (let ((pixmap (clim:with-output-to-pixmap
                        (pixmap-medium pane
                                       :width (ceiling max-x)
                                       :height (ceiling max-y))
                      (clim:draw-pattern* pixmap-medium pattern 0 0))))
        (clim:add-output-record
         (make-instance 'pixmap-output-record
           :pixmap pixmap
           :parent nil
           :size nil)
         history)))))

(defun docleanser (filename)
  (clim:run-frame-top-level
   (clim:make-application-frame 'docleanser
     :image (clim:make-pattern-from-bitmap-file filename))))
