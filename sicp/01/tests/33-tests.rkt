#lang racket

(require rackunit rackunit/text-ui)

(load "./33.rkt")

(define sicp-01.33-tests
  (test-suite
   "testing 01.33 filtered-accumulate procedure abstraction"

   (check-equal? (+ (filtered-accumulate even? + 0 identity 1 inc 10)
                    (filtered-accumulate odd? + 0 identity 1 inc 10))
                 55)

   (check-equal? (product-of-positive-relative-primes 10) 189)
   (check-equal? (product-of-positive-relative-primes 12) 385)
))

(run-tests sicp-01.33-tests)
