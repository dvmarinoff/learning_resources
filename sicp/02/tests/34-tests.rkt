#lang racket

(require rackunit rackunit/text-ui)

(load "./34.rkt")

(define sicp-02.34-tests
  (test-suite
   "testing 02.34 Horner's rule"

   (check-equal? (horner-eval 2 (list 1 3 0 5 0 1)) 79)
))

(run-tests sicp-02.34-tests)
