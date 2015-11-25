;;;; deriv.lisp

(in-package #:symbolic)

(defun =number? (exp num)
  (and (numberp exp)
       (= exp num)))

(defun variable? (e)
  (symbolp e))

(defun same-variable? (v1 v2)
  (and (variable? v1)
       (variable? v2)
       (eql v1 v2)))

(defun sum? (e)
  (and (consp e)
       (eql (car e) '+)))

(defun addend (e)
  (cadr e))

(defun augend (e)
  (caddr e))

(defun make-sum (a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        (t (list '+ a1 a2))))

(defun product? (e)
  (and (consp e)
       (eql (car e) '*)))

(defun multiplier (e)
  (cadr e))

(defun multiplicand (e)
  (caddr e))

(defun make-product (a1 a2)
  (cond ((or (=number? a1 0)
             (=number? a2 0)) 0)
        ((=number? a1 1) a2)
        ((=number? a2 1) a1)
        (t (list '* a1 a2))))

(defun deriv (exp var)
  (cond ((numberp exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum (make-product (multiplier exp)
                                 (deriv (multiplicand exp) var))
                   (make-product (deriv (multiplier exp) var)
                                 (multiplicand exp))))
        (t (error "Unknown expression type -- DERIV ~A" exp))))
