#lang racket

(require rackunit rackunit/text-ui)

(load "../05.rkt")

(define sicp-03.05-tests
  (test-suite
   "testing 03.05 Monte Carlo integration - estimate-integral procedure"

   (check-= (estimate-pi) 3.14 0.01)
))

(run-tests sicp-03.05-tests)
