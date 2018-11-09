#lang racket

(require rackunit rackunit/text-ui)

(load "../73.rkt")

(define sicp-02.73-tests
  (test-suite
   "testing 02.73 data-directed deriv package"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.73-tests)
