#lang racket

(require rackunit rackunit/text-ui)

(load "../10.rkt")

(define sicp-03.10-tests
  (test-suite
   "testing 03.10 analyze make-withdraw with environment model"

    (check-equal? (main 0) 0)
))

(run-tests sicp-03.10-tests)
