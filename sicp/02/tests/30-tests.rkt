#lang racket

(require rackunit rackunit/text-ui)

(load "./30.rkt")

(define sicp-02.30-tests
  (test-suite
   "testing 02.30 binary mobile square-tree procedure"

    (check-equal? (square-tree '()) '())
    (check-equal? (square-tree '(1)) '(1))
    (check-equal? (square-tree '(2)) '(4))
    (check-equal? (square-tree '(1 2 3 4)) '(1 4 9 16))
    (check-equal? (square-tree '((1 2) (3 4))) '((1 4) (9 16)))
    (check-equal? (square-tree '((1 2) (3 4 (5 6 (7 8))))) '((1 4) (9 16 (25 36 (49 64)))))
    (check-equal? (square-tree '((1 2) (3 4 (5 6)) (7 8))) '((1 4) (9 16 (25 36)) (49 64)))

    (check-equal? (sqr-tree '()) '())
    (check-equal? (sqr-tree '(1)) '(1))
    (check-equal? (sqr-tree '(2)) '(4))
    (check-equal? (sqr-tree '(1 2 3 4)) '(1 4 9 16))
    (check-equal? (sqr-tree '((1 2) (3 4))) '((1 4) (9 16)))
    (check-equal? (sqr-tree '((1 2) (3 4 (5 6 (7 8))))) '((1 4) (9 16 (25 36 (49 64)))))
    (check-equal? (sqr-tree '((1 2) (3 4 (5 6)) (7 8))) '((1 4) (9 16 (25 36)) (49 64)))
))

(run-tests sicp-02.30-tests)
