#lang racket

(require rackunit rackunit/text-ui)

(load "./07.rkt")

(define sicp-02.07-tests
  (test-suite
   "testing 02.07 selectors for interval arithmetic"

    (check-equal? (lower-bound (make-interval 1.1 1.4)) 1.1)
    (check-equal? (upper-bound (make-interval 1.1 1.4)) 1.4)
))

(run-tests sicp-02.07-tests)
