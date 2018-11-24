#lang racket

(require rackunit rackunit/text-ui)

(load "./01-part-2.rkt")

(define aoc.2017.01p2-tests
  (test-suite
   "testing 2017.01 Inverse Captcha"

   (check-equal? (cadr-halfway-around 2 (list 1 2 3 4)) 3)
   (check-equal? (cadr-halfway-around 2 (list 2 3 4)) 4)

   (check-equal? (match-sum (list 1 2 2 1)) 0 "(1 2 2 1)")
   (check-equal? (match-sum (list 1 2 1 2)) 6 "(1 2 1 2)")
   (check-equal? (match-sum (list 1 2 3 4 2 5)) 4
                 "(1 2 3 4 2 5)")
   (check-equal? (match-sum (list 1 2 3 1 2 3)) 12
                 "(1 2 3 1 2 3)")
   (check-equal? (match-sum (list 1 2 1 3 1 4 1 5)) 4
                 "()")

   (check-equal? (match-sum int-lst) 1146 "answer")
   ))

(run-tests aoc.2017.01p2-tests)
