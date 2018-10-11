#lang racket

(require rackunit rackunit/text-ui)

(load "./12.rkt")

(define sicp-02.12-tests
  (test-suite
   "testing 02.12 interval arithmetic make-center-percent constructor"

    (check-= 4.28
             (percent (make-center-percent 3.5 4.28))
             0.001)
))

(run-tests sicp-02.12-tests)
