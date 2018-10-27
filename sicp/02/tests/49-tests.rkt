#lang racket

(require rackunit rackunit/text-ui)

(load "../49.rkt")

(define sicp-02.49-tests
  (test-suite
   "testing 02.49 picture language segments->painter"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.49-tests)
