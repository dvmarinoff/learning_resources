#lang racket

(require rackunit rackunit/text-ui)

(load "./24.rkt")

(define sicp-02.24-tests
  (test-suite
   "testing 02.24 examine nested lists"

    (check-equal? 1 1)
))

(run-tests sicp-02.24-tests)
