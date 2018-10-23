#lang racket

(require rackunit rackunit/text-ui)

(load "./32.rkt")

(define sicp-02.32-tests
  (test-suite
   "testing 02.32 the power set"

   (check-equal? (subsets '(1 2 3)) '(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3)))
))

(run-tests sicp-02.32-tests)
