(ql:quickload "symbolic")

(symbolic:deriv '(+ x 3) 'x)

(symbolic:deriv '(* x y) 'x)

(symbolic:deriv '(* (* x y) (+ x 3)) 'x)

(symbolic:deriv '(+ x x) 'x)
