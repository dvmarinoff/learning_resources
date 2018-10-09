#lang racket

(require rackunit rackunit/text-ui)

(load "./02.rkt")

(define sicp-02.02-tests
  (test-suite
   "testing 02.02 representing line segments in a plane"

    (check-equal? mid-point-p1-p2 (cons 2.0 2.0))
    (check-equal? (make-segment p1 p2) (cons (cons 1.0 1.0)
                                             (cons 3.0 3.0)))
    (check-equal? (make-point 4.0 4.0) (cons 4.0 4.0))
))

(run-tests sicp-02.02-tests)
