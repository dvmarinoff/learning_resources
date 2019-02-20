#lang racket

(require rackunit rackunit/text-ui)

(load "../25.rkt")

(define sicp-03.25-tests
  (test-suite
   "testing 03.25 lookup and insert! with lists of keys"

    (check-equal? (main 0) 0)
))

(run-tests sicp-03.25-tests)
