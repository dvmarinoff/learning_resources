#lang racket

(require rackunit rackunit/text-ui)

(load "./01-part-1.rkt")

(define aoc.2017.01p1-tests
  (test-suite
   "testing 2017.01 Inverse Captcha"


   (check-true (cycle? (list 1 1)))
   (check-true (cycle? (list 1 1 1)))
   (check-true (cycle? (list 1 3 1)))
   (check-false (cycle? (list 3 1)))
   (check-false (cycle? (list 1 3)))
   (check-false (cycle? (list 3)))

   (check-equal? (accumulator (list 1 1)) 1)
   (check-equal? (accumulator (list 1 3)) 0)

   (check-equal? (match-sum (list 1 2 3 4)) 0 "(1 2 3 4)")
   (check-equal? (match-sum (list 1 1 1 1)) 4 "(1 1 1 1)")
   (check-equal? (match-sum (list 9 1 2 1 2 1 2 9)) 9
                 "(9 1 2 1 2 1 2 9)")
   (check-equal? (match-sum int-lst) 1203 "answer")
   ))

(run-tests aoc.2017.01p1-tests)
