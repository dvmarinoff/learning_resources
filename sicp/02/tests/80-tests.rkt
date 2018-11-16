#lang racket

(require rackunit rackunit/text-ui)

(load "../80.rkt")

(define sicp-02.80-tests
  (test-suite
   "testing 02.80 generic =zero? predicate"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.80-tests)
