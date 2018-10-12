#lang racket

(require rackunit rackunit/text-ui)

(load "./19.rkt")

(define sicp-02.19-tests
  (test-suite
   "testing 02.19 extend change-counting with lists"

   (check-equal? (cc 100 us-coins) 292)
   (check-equal? (cc 10 uk-coins) 50)
   (check-equal? (cc 1 uk-coins) 2)
))

(run-tests sicp-02.19-tests)
