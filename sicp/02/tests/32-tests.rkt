#lang racket

(require rackunit rackunit/text-ui)

(load "../32.rkt")

(define sicp-02.32-tests
  (test-suite
   "testing 02.32 set of subsets of a set"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.32-tests)
