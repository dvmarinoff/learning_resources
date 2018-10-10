#lang racket

(require rackunit rackunit/text-ui)

(load "./08.rkt")

(define sicp-02.08-tests
  (test-suite
   "testing 02.08 interval arithmetic sub-interval procedure"

   (check-equal? (sub-interval (make-interval 2.0 2.1)
                               (make-interval 1.0 1.1))
                 (cons 1.0 1.0))

   (check-equal? (sub-interval (make-interval 2.0 2.1)
                               (make-interval 2.0 2.1))
                 (cons 0.0 0.0))
))

(run-tests sicp-02.08-tests)
