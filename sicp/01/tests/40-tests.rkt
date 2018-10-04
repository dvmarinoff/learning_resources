#lang racket

(require rackunit rackunit/text-ui)

(load "./40.rkt")

(define sicp-01.40-tests
  (test-suite
   "testing 01.40 cubic for newton's method"

    (check-= (newtons-method (cubic 0 0 -1) 2.0) 1.0 0.00001)
    (check-= (newtons-method (cubic 0 0 -27) 2.0) 3.0 0.00001)
))

(run-tests sicp-01.40-tests)
