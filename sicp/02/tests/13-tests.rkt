#lang racket

(require rackunit rackunit/text-ui)

(load "./13.rkt")

(define sicp-02.13-tests
  (test-suite
   "testing 02.13 interval arithmetic simplified approximate percentage"

   (check-= (percent c)
            (approximate-product-percentage a b)
            0.01)
))

(run-tests sicp-02.13-tests)
