#lang racket

(require rackunit rackunit/text-ui)

(load "../37.rkt")

(define sicp-01.37-tests
  (test-suite
   "testing 01.37 infinite continued fraction"

    (check-equal? (main 0) 0)
))

(run-tests sicp-01.37-tests)
