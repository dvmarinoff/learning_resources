#lang racket

(require rackunit rackunit/text-ui)

(load "./22.rkt")

(define sicp-02.22-tests
  (test-suite
   "testing 02.22 square-list iterative process problems"

    (check-equal? 0 0)
))

(run-tests sicp-02.22-tests)
