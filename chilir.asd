(defsystem :chilir
  :author "Karl Hallsby <karl@hallsby.com>"
  :description "ChilIR, Constructing Hardware in Lisp IR"
  :pathname #p"source/"
  :components ((:file "chilir"))
  :in-order-to ((test-op (test-op "chilir/tests"))))

(defsystem :chilir/tests
  :depends-on (:chilir :alexandria :lisp-unit2)
  :pathname #p"tests/"
  :components ((:file "example")))

(defmethod asdf:perform ((o asdf:test-op) (c (eql (find-system :chilir))))
  ;; ASDF produces this warning
  ;;WARNING:
  ;; Deprecated recursive use of (ASDF/OPERATE:OPERATE 'ASDF/LISP-ACTION:LOAD-OP
  ;; '("chilir/tests")) while visiting (ASDF/LISP-ACTION:TEST-OP "chilir") - please
  ;; use proper dependencies instead
  ;; This occurs because I invoke ASDF's operate inside another call to asdf:operate
  ;; See https://gitlab.common-lisp.net/asdf/asdf/-/issues/13 for how to fix
  (asdf:oos 'asdf:load-op :chilir/tests)
  (let ((*package* (find-package :chilir/tests)))
    (eval (read-from-string "
            (lisp-unit2:with-summary ()
             (lisp-unit2:run-tests
              :package :chilir/tests
              :name :chilir))
      "))))
