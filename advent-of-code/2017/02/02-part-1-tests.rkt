#lang racket

(require rackunit rackunit/text-ui)

(load "./02-part-1.rkt")

(define aoc.2017.02p1-tests
  (test-suite
   "testing 2017.02 Corruption Checksum"

   (check-equal? (min (list 5 1 9 5)) 1)
   (check-equal? (max (list 5 1 9 5)) 9)
   (check-equal? (min-max (list 5 1 9 5)) (cons 1 9))
   (check-equal? (difference-min-max-pair (cons 1 9)) 8)
   (check-equal? (difference-min-max-pair (cons 0 8)) 8)

   (check-equal? (check-sum 0 test-matrix) 18)

   (check-equal? (check-sum 0 int-matrix) 44670 "answer")

   ))

(run-tests aoc.2017.02p1-tests)
