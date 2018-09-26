#lang racket

(require rackunit rackunit/text-ui)

(load "./29.rkt")

(define sicp-01.29-tests
  (test-suite
   "testing 01.29 Simpson's rule"

    (check-equal? (y-coefficient 100 0) 1)
    (check-equal? (y-coefficient 100 1) 4)
    (check-equal? (y-coefficient 100 2) 2)
    (check-equal? (y-coefficient 100 3) 4)
    (check-equal? (y-coefficient 100 4) 2)
    (check-equal? (y-coefficient 100 (- 100 2)) 2)
    (check-equal? (y-coefficient 100 (- 100 1)) 4)
    (check-equal? (y-coefficient 100 100) 1)

    (check-equal? (h-value 1.0 4.0 100) 0.03)

    (check-equal? (y cube 1 0.03 0) 1)
    (check-equal? (y cube 1 0.03 1) (cube 1.03))
    (check-equal? (y cube 1 0.03 2) (cube 1.06))

    (check-equal? ((y-term cube 1.0 0.03 100) 0) (* 1.0 1))

    (check-= (simpsons-method cube 1.0 4.0 100)
             (definite-integral 1.0 4.0 anti-deriv-cube)
             0.01)
    (check-= (simpsons-method cube 1.0 4.0 1000)
             (definite-integral 1.0 4.0 anti-deriv-cube)
             0.001)
))

(run-tests sicp-01.29-tests)
