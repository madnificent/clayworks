(in-package :cw.helpers)

(defgeneric show-object (object)
  (:documentation "Shows an object in html form"))



(in-package :cw.setup.helpers)

;;;;;;;;;;;;;;;;;;
;;;; backend store
(defvar *db-dir* nil
  "Contains the path to the current db-dir")
(defun db-dir ()
  "Setfable place for the store directory"
  *db-dir*)
(defun (setf db-dir) (path)
  (when *db-dir*
    (close-store))
  (open-store path)
  (setf *db-dir* path))

;;;;;;;;;;;;;;;;;;;;;
;;;; start the server
(defvar *debug-in-repl-p* t
  "You need to (re)start the server after setting this variable in order to apply the changes")
(defun enable-debug-in-repl (acceptor)
  "An ugly function which enables the debugging features in the repl"
  (let ((dispatcher (hunchentoot:acceptor-request-dispatcher acceptor)))
    (setf (hunchentoot:acceptor-request-dispatcher acceptor)
	  (lambda (&rest args)
	    (if *debug-in-repl-p*
		(handler-bind
		    ((error (lambda  (err) (invoke-debugger err))))
		  (apply dispatcher args))
		(apply dispatcher args))))))
;; see http://paste.lisp.org/display/83241

(defvar *my-acceptor* nil
  "Contains the hunchentoot server acceptor")
(defun start-server (&key (port 8080))
  "Starts the server so the page displaying can begin.  If a server is currently running, it will be stopped."
  (when *my-acceptor*
    (hunchentoot:stop *my-acceptor*))
  (setf *my-acceptor* (make-instance 'hunchentoot:acceptor :port port))
  (hunchentoot:start *my-acceptor*)
  (when *debug-in-repl-p*
    (enable-debug-in-repl *my-acceptor*)))
