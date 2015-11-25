;;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Base: 10 -*-
;;;; deriv.asd

(defpackage #:symbolic-asd
  (:use :cl :asdf))

(in-package :symbolic-asd)

(asdf:defsystem #:symbolic
    :name "symbolic"
    :version "0.0.1"
    :author "Guillaume MICHEL <guillaume.michel@orilla.fr>"
    :licence "BSD sans advertising clause (see file COPYING for details)"
    :description "Symbolic package"
    :long-description "Symbolic expression operation like derivation, ..."
    :serial t
    :components ((:file "package")
                 (:file "deriv")))
