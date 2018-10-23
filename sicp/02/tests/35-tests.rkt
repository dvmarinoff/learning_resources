#lang racket

(require rackunit rackunit/text-ui)

(load "./35.rkt")

(define sicp-02.35-tests
  (test-suite
   "testing 02.35 count-leaves as accumulation"

   (check-equal? (count-leaves '()) 0)
   (check-equal? (count-leaves '(0)) 1)
   (check-equal? (count-leaves '(1 2 3 4)) 4)
   (check-equal? (count-leaves '((1 2) (3 4))) 4)
   (check-equal? (count-leaves '((1 2) (3 4 (5 6 (7 8))))) 8)
))

(run-tests sicp-02.35-tests)
