#lang racket

(require rackunit rackunit/text-ui)

(load "../27.rkt")

(define sicp-03.27-tests
  (test-suite
   "testing 03.27 memoization environment diagram for fibonacci"

    (check-equal? (main 0) 0)
))

(run-tests sicp-03.27-tests)
