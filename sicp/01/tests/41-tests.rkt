#lang racket

(require rackunit rackunit/text-ui)

(load "./41.rkt")

(define sicp-01.41-tests
  (test-suite
   "testing 01.41 double apply"

   (check-equal? ((double inc) 1) 3)

   (check-equal? (((double (double double)) inc) 5) 21)
))

(run-tests sicp-01.41-tests)
