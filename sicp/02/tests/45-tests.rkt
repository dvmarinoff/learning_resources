#lang racket

(require rackunit rackunit/text-ui)

(load "../45.rkt")

(define sicp-02.45-tests
  (test-suite
   "testing 02.45 picture language generalized split procedure"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.45-tests)
