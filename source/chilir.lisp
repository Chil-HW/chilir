(defpackage :chilir
  (:use :cl)
  (:export #:hello))

(in-package :chilir)

(defun hello ()
  (format t "Hello to Chilir!~&"))
