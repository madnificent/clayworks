(defpackage :clayworks.sysdef
  (:use :common-lisp :asdf))

(in-package :clayworks.sysdef)

(defsystem :clayworks
  :name "clayworks web development stack"
  :author "Aad Versteden <madnificent@gmail.com>"
  :version "0"
  :maintainer "Aad Versteden <madnificent@gmail.com>"
  :licence "BSD"
  :description "Full stack web development framework, ready to develop applications in."
  :depends-on (:claymore
	       :rofl
	       :database-migrations)
  :components ((:file "packages")))