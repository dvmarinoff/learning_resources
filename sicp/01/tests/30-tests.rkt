#lang racket

(require rackunit rackunit/text-ui)

(load "./30.rkt")

(define sicp-01.30-tests
  (test-suite
   "testing 01.30 iterative sum"

   (check-equal? (sum identity 1 inc 10) 55)
   (check-equal? (sum identity 1 inc -10) 0)
   (check-equal? (sum identity 1 inc 1) 1)
))

(run-tests sicp-01.30-tests)
