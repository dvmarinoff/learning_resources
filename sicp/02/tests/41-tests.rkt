#lang racket

(require rackunit rackunit/text-ui)

(load "../41.rkt")

(define sicp-02.41-tests
  (test-suite
   "testing 02.41 ordered pairs of distinct positive integers"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.41-tests)
