#lang racket

(require rackunit rackunit/text-ui)

(load "../36.rkt")

(define sicp-01.36-tests
  (test-suite
   "testing 01.36 explore the fixed-point procedure"

    (check-equal? (main 0) 0)
))

(run-tests sicp-01.36-tests)
