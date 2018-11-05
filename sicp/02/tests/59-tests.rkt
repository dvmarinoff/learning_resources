#lang racket

(require rackunit rackunit/text-ui)

(load "./59.rkt")

(define sicp-02.59-tests
  (test-suite
   "testing 02.59 sets as unordered-lists union-set"

    (check-equal? (union-set '(1) '(2)) '(1 2))
    (check-equal? (union-set '(1 2 3) '(4 5 6)) '(1 2 3 4 5 6))
    (check-equal? (union-set '(1 2 (3 4)) '(5 6 7)) '(1 2 (3 4) 5 6 7))
))

(run-tests sicp-02.59-tests)
