(in-package :mvc)

(defparameter *pcdv* (make-instance 'flow :order '(parameters controller director view)))

;;;; This system allows for an extended mvc system to be used within your code.
;;;;
;;;; The splits enforce high cohesion within and low coupling between the separate components.  This allows you to easily reuse the compontents and grasp what they do and how they should do it.
;;;; It might take a minute to get used to this system, so you may be interested in checking out blogworks, to see how this can be used in a running system.
;;;;  (as of 2009-06-28 this hasn't been included in blogworks just yet.  It will be included when the database backend is finalized)

(defmacro parameters (name args &body body)
  "This section will handle the parsing of the variables, so they can be used in the next stage of the flow.
Splitting the fetching of the variables in a separate part of the code, makes the code easier ot reuse in cases when the parameters might be fetched otherwise."
  `(defflow *mvcp* 'view ',name ,(or args (list 'arg))
     ,@body)))

(defmacro controller (name args &body body)
  "Defines a new conttroller, which will handle the changes enflicted upon the model.
Any state you alter, should be done in here.  This will allow you to quickly find where the changes happen, and thus allows you to find bugs easier."
  `(defflow *mvcp* 'controller ',name ,(or args (list 'arg))
     ,@body))

(defmacro director (name args &body body)
  "Defines a new director.  This is the part that decides what view will be shown.  For this, it uses the variables from the previous stage (controller).
The decisions as to which view should be shown (and what parameters to give to it) is something that lies between the actual modification and the showing of the data.  Again, this part allows for quicker reuse of the created code.  Here, you can discover why a certain page is shown (and update it, if management asks you to do so)."
  `(defflow *mvcp* 'director ',name ,(or args (list 'arg))
     ,@body))

(defmacro view (name args &body body)
  "Defines a new view.  This is what the user will see.
How the user interface is shown should be made completely independent of how the system acts.  By creating the views separately, a simple and clean portion of the code can be used."
  `(defflow *mvcp* 'view ',name ,(or args (list 'arg))
     ,@body))
