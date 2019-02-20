#lang racket

(require rackunit rackunit/text-ui)

(load "./59.rkt")

(define sicp-02.59-tests
  (test-suite
   "testing 02.59 sets as unordered-lists union-set"

    (check-equal? (union-set '(1) '(2)) '(1 2))
    (check-equal? (union-set '(1 2 3) '(4 5 6)) '(3 2 1 6 5 4))
    (check-equal? (union-set '(1 2 (3 4)) '(5 6 7)) '((3 4) 2 1 7 6 5))
    (check-equal? (union-set '(1) '(1 2)) '(2 1))
    (check-equal? (union-set '(1) '(1 2 2)) '(2 1))
    (check-equal? (union-set '(1 1) '(2)) '(1 2))
    (check-equal? (union-set '(1 2 3 3) '(4 4 5 6)) '(3 2 1 6 5 4))
))

(run-tests sicp-02.59-tests)
