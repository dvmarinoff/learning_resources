#lang racket

(require rackunit rackunit/text-ui)

(load "./31.rkt")

(define sicp-01.31-tests
  (test-suite
   "testing 01.31 higher-order product procedure"

   (check-equal? (product-iter identity 1 inc 4) 24)
   (check-equal? (product-iter identity 1 inc -4) 1)
   (check-equal? (product-iter identity 1 inc 1) 1)
   (check-equal? (product-iter sqr 1 inc 4) 576)
))

(run-tests sicp-01.31-tests)
