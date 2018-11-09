#lang racket

(require rackunit rackunit/text-ui)

(load "../09.rkt")

(define sicp-03.09-tests
  (test-suite
   "testing 03.09 environment structures - evaluating recursion and iteration"

    (check-equal? (main 0) 0)
))

(run-tests sicp-03.09-tests)
