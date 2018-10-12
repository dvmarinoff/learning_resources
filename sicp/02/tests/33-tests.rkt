#lang racket

(require rackunit rackunit/text-ui)

(load "../33.rkt")

(define sicp-02.33-tests
  (test-suite
   "testing 02.33 practice accumulaation lambdas"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.33-tests)
