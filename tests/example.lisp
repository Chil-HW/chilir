(defpackage :chilir/tests
  (:use :cl :lisp-unit2))

(in-package :chilir/tests)

(define-test example ()
  (assert-eql 1 (- 2 1)))
