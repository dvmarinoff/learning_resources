#lang racket

(require rackunit rackunit/text-ui)

(load "./26.rkt")

(define sicp-02.26-tests
  (test-suite
   "testing 02.26 examine append, cons and list differences"

   (check-equal? (append x y) '(1 2 3 4 5 6))
   (check-equal? (cons x y) '((1 2 3) 4 5 6))
   (check-equal? (list x y) '((1 2 3) (4 5 6)))
))

(run-tests sicp-02.26-tests)
