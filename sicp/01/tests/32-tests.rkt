#lang racket

(require rackunit rackunit/text-ui)

(load "./32.rkt")

(define sicp-01.32-tests
  (test-suite
   "testing 01.32 accumulate procedure abstraction"

   (check-equal? (sum identity 1 inc 1) 1)
   (check-equal? (sum identity 1 inc -1) 0)
   (check-equal? (sum identity 1 inc 10) 55)
   (check-equal? (sum sqr 1 inc 10) 385)

   (check-equal? (product identity 1 inc 1) 1)
   (check-equal? (product identity 1 inc -1) 1)
   (check-equal? (product identity 1 inc 4) 24)
   (check-equal? (product sqr 1 inc 4) 576)
))

(run-tests sicp-01.32-tests)
