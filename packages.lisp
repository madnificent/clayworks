(defpackage :mvc
  (:use :common-lisp :flow)
  (:export :defparameters
	   :defcontroller
	   :defcontroller-t
	   :defdirector
	   :defview
	   :*mvcp*))

(defpackage :cw.helpers
  (:use :common-lisp
	:flow)
  (:export :show-object))

(defpackage :cw.setup.helpers
  (:use :common-lisp
	:bknr.datastore
	:claymore.routing)
  (:export :db-dir
	   :start-server
	   :*debug-in-repl-p*))

#.(let ((packages '(:claymore.routing :cw.setup.helpers :common-lisp))
	all-symbols)
    (loop for package in packages
       do (do-external-symbols (symbol package) (pushnew symbol all-symbols)))
    `(defpackage :cw.setup
       (:use ,@packages)
       (:export ,@all-symbols)))

#.(let ((packages '(:claymore.html :common-lisp :parenscript :cl-css :mvc :flow))
	all-symbols)
    (loop for package in packages
       do (do-external-symbols (symbol package) (pushnew symbol all-symbols)))
    `(defpackage :cw.site
       (:use ,@packages)
       (:export ,@all-symbols)
       (:shadowing-import-from :cl-css em)
       (:shadowing-import-from :parenscript % label)))