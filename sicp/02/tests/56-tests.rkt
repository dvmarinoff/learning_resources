#lang racket

(require rackunit rackunit/text-ui)

(load "./56.rkt")

(define sicp-02.56-tests
  (test-suite
   "testing 02.56 add power rule"

   (check-true (sum? (make-sum 'x 'y)) "sum?")
   (check-equal? (addend (make-sum 'x 'y)) 'x "addend")
   (check-equal? (augend (make-sum 'x 'y)) 'y "augend")

   (check-true (exponentiation? (make-exponetiation 2 3))
               "exponentiation?")
   (check-equal? (base (make-exponetiation 'x 'n)) 'x
                 "base")
   (check-equal? (exponent (make-exponetiation 'x 'n)) 'n
                 "exponent")
))

(run-tests sicp-02.56-tests)
