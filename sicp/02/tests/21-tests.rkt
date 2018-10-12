#lang racket

(require rackunit rackunit/text-ui)

(load "./21.rkt")

(define sicp-02.21-tests
  (test-suite
   "testing 02.21 square-list procedure"

   (check-equal? (square-list (list 1 2 3 4)) (list 1 4 9 16))
   (check-equal? (square-list (list 3)) (list 9))
   (check-equal? (square-list '()) '())
))

(run-tests sicp-02.21-tests)
