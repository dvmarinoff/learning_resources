#lang racket

(require rackunit rackunit/text-ui)

(load "../40.rkt")

(define sicp-02.40-tests
  (test-suite
   "testing 02.40 unique pair procedure"

   (check-equal? (unique-pairs 0) '())
   (check-equal? (unique-pairs 3) '((2 1) (3 1) (3 2)))

   (check-equal? (prime-sum-pairs 0) '())
   (check-equal? (prime-sum-pairs 3) '((2 1 3) (3 2 5)))
))

(run-tests sicp-02.40-tests)
