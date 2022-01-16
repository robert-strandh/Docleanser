(cl:in-package #:docleanser)

(defclass pixmap-output-record (clim:displayed-output-record)
  ((%parent
    :initarg :parent
    :accessor clim:output-record-parent)
   (%x-position :initform 0 :reader x-position)
   (%y-position :initform 0 :reader y-position)
   (%pixmap :initarg :pixmap :reader pixmap)
   (%size :initarg :size :reader size)))

(defmethod clim:bounding-rectangle* ((region pixmap-output-record))
  (let ((pixmap (pixmap region)))
    (values 0 0 (clim:pixmap-width pixmap) (clim:pixmap-height pixmap))))

(defmethod clim:output-record-refined-position-test
    ((region pixmap-output-record) x y)
  t)

(defmethod clim:output-record-position ((record pixmap-output-record))
  (values (x-position record) (y-position record)))

(defmethod clim:output-record-start-cursor-position
    ((record pixmap-output-record))
  (values nil nil))

(defmethod clim:output-record-end-cursor-position
    ((record pixmap-output-record))
  (values nil nil))

(defmethod clim:replay-output-record
    ((record pixmap-output-record) stream
     &optional region x-offset y-offset)
  (declare (ignore region x-offset y-offset))
  (let* ((pixmap (pixmap record))
         (height (clim:pixmap-height pixmap))
         (width (clim:pixmap-width pixmap)))
    (clim:copy-from-pixmap pixmap 0 0 width height stream 0 0)))
