#lang racket

(require rackunit rackunit/text-ui)

(load "../26.rkt")

(define sicp-03.26-tests
  (test-suite
   "testing 03.26 ordered tables"

    (check-equal? (main 0) 0)
))

(run-tests sicp-03.26-tests)
