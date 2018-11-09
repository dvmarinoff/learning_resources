#lang racket

(require rackunit rackunit/text-ui)

(load "../06.rkt")

(define sicp-03.06-tests
  (test-suite
   "testing 03.06 random generator with reset"

    (check-equal? (main 0) 0)
))

(run-tests sicp-03.06-tests)
