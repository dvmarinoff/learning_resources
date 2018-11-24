#lang racket

(require rackunit rackunit/text-ui)

(load "./02-part-2.rkt")

(define aoc.2017.02p2-tests
  (test-suite
   "testing 2017.02 Corruption Checksum"

   (check-true (even-division? 8 2))
   (check-true (even-division? 2 8))
   (check-false (even-division? 3 8))
   (check-false (even-division? 0 9))

   (check-equal? (find-divisible-pair (list 5 9 2 8)) (cons 8 2))
   (check-equal? (find-divisible-pair (list 9 4 7 3)) (cons 9 3))
   (check-equal? (find-divisible-pair (list 3 8 6 5)) (cons 6 3))

   (check-equal? (check-sum 0 test-matrix) 9)

   (check-equal? (check-sum 0 int-matrix) 285 "answer")

   ))

(run-tests aoc.2017.02p2-tests
)
