#lang racket

(require rackunit rackunit/text-ui)

(load "../05.rkt")

(define sicp-03.05-tests
  (test-suite
   "testing 03.05 Monte Carlo integration - estimate-integral procedure"

    (check-equal? (main 0) 0)
))

(run-tests sicp-03.05-tests)
