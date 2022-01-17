(cl:in-package #:docleanser)

(clim:define-application-frame docleanser ()
  ((%document-pattern :initarg :document-pattern :reader document-pattern)
   (%zoom-percent :initform 40 :accessor zoom-percent)
   (%pixmap :initform nil :accessor pixmap))
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
  (with-accessors ((document-pattern document-pattern)
                   (zoom-percent zoom-percent)
                   (pixmap pixmap))
      frame
    (when (null pixmap)
      (let* ((zoom-factor (/ zoom-percent 100))
             (transformation
               (clim:make-scaling-transformation* zoom-factor zoom-factor))
             (pattern (clim:transform-region transformation document-pattern)))
        (multiple-value-bind (min-x min-y max-x max-y)
            (clim:bounding-rectangle* pattern)
          (declare (ignore min-x min-y))
          (setf pixmap
                (clim:with-output-to-pixmap
                    (pixmap-medium pane
                                   :width (ceiling max-x)
                                   :height (ceiling max-y))
                  (clim:draw-pattern* pixmap-medium pattern 0 0))))))
    (let ((history (clim:stream-output-history pane)))
      (clim:add-output-record
       (make-instance 'pixmap-output-record
         :pixmap pixmap
         :parent nil
         :size nil)
       history)
      (clim:replay history pane))))

(defun docleanser (filename)
  (clim:run-frame-top-level
   (clim:make-application-frame 'docleanser
     :document-pattern (clim:make-pattern-from-bitmap-file filename))))

(define-docleanser-command (com-nothing :name t)
    ()
  nil)
