#lang racket

(require rackunit rackunit/text-ui)

(load "./62.rkt")

(define sicp-02.62-tests
  (test-suite
   "testing 02.62 sets as ordered-lists union-set in O(n)"

    (check-equal? (union-set '() '(1 2)) '(1 2))
    (check-equal? (union-set '(3 4) '()) '(3 4))
    (check-equal? (union-set '(3 4) '(1 2)) '(1 2 3 4))
    (check-equal? (union-set '(3 4) '(1 2 3)) '(1 2 3 3 4))
))

(run-tests sicp-02.62-tests)
