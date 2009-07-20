(in-package :cw.helpers)

(defgeneric show-object (object)
  (:documentation "Shows an object in html form"))
(defmethod show-object ((object standard-object))
  (>:table (>:tr (>:th "variable") (>:th "content"))
	   (loop for slot in (fridge::class-direct-slots (class-of object)) collect
		(>:tr (>:td (format nil "~A" (slot-value slot 'sb-pcl::name)))
		      (>:td (format nil "~A" (slot-value object (slot-value slot 'sb-pcl::name))))))))
