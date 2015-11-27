(ql:quickload "symbolic")

(symbolic:deriv '(+ x 3) 'x)

(symbolic:deriv '(* x y) 'x)

(symbolic:deriv '(* (* x y) (+ x 3)) 'x)

(symbolic:deriv '(+ x x) 'x)

(symbolic:deriv '(* x y (+ x 3)) 'x)

(symbolic:deriv '(* x y z) 'x)

(symbolic:deriv '(+ x y 0) 'x)

(symbolic:deriv '(+ x y 0 z x) 'x)
