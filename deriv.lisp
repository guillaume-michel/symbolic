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
  (let ((aug (cddr e)))
    (if (= (length aug) 1)
        (car aug)
        (make-sum-list aug))))

(defun make-sum-list (l)
  (if (= (length l) 2)
      (list '+ (car l) (cadr l))
      (make-sum (car l) (make-sum-list (cdr l)))))

(defun make-sum (a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (numberp a1) (numberp a2)) (+ a1 a2))
        (t (make-sum-list (list a1 a2)))))

(defun product? (e)
  (and (consp e)
       (eql (car e) '*)))

(defun multiplier (e)
  (cadr e))

(defun multiplicand (e)
  (let ((m (cddr e)))
    (if (= (length m) 1)
        (car m)
        (make-product-list m))))

(defun make-product-list (l)
  (if (= (length l) 2)
      (list '* (car l) (cadr l))
      (make-product (car l) (make-product-list (cdr l)))))

(defun make-product (m1 m2)
  (cond ((or (=number? m1 0)
             (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (numberp m1) (numberp m2)) (* m1 m2))
        (t (make-product-list (list m1 m2)))))

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
