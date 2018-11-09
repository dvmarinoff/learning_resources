#lang racket

(require rackunit rackunit/text-ui)

(load "../08.rkt")

(define sicp-03.08-tests
  (test-suite
   "testing 03.08 order of evalkuation with mutable state"

    (check-equal? (main 0) 0)
))

(run-tests sicp-03.08-tests)
