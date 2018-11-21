#lang racket

(require rackunit rackunit/text-ui)

(load "./08.rkt")

(define sicp-03.08-tests
  (test-suite
   "testing 03.08 order of evalkuation with mutable state"

    (check-equal? (+ (f 0) (f 1)) 0)
    (check-equal? (+ (f 1) (f 0)) 1)
))

(run-tests sicp-03.08-tests)
