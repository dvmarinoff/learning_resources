#lang racket

(require rackunit rackunit/text-ui)

(load "./61.rkt")

(define sicp-02.61-tests
  (test-suite
   "testing 02.61 sets as ordered-lists adjoin-set"

    (check-equal? (adjoin-set 1 '()) '(1))
    (check-equal? (adjoin-set 3 '(1 2 4)) '(1 2 3 4))
    (check-equal? (adjoin-set 3 '(1 2 3 4)) '(1 2 3 3 4))
))

(run-tests sicp-02.61-tests)
