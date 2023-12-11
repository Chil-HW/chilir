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

(defmethod asdf:perform ((o asdf:test-op) (c (eql (find-system :chilir/tests))))
  ;; Binding `*package*' to package-under-test makes for more reproducible tests.
  (let ((*package* (find-package :chilir/tests)))
    (uiop:symbol-call
     :lisp-unit2 :run-tests
     :package *package*
     :name :chilir
     :run-contexts (find-symbol "WITH-SUMMARY-CONTEXT" :lisp-unit2))))
