#lang racket

(require rackunit rackunit/text-ui)

(load "./78.rkt")

(define four (make-scheme-number 4))
(define three (make-scheme-number 3))
(define three-fourths (make-rational three four))
(define one-fourth (make-rational 1 4))

(define sicp-02.78-tests
  (test-suite
   "testing 02.78 native lisp types"

    (check-equal? (add four three) 7)
    (check-equal? (div four three) 4/3)
    (check-equal? (sub four three) 1)
    (check-equal? (mul four three) 12)

    (check-equal? (add one-fourth three-fourths) (make-rational 1 1))
    (check-equal? (add one-fourth one-fourth) (make-rational 1 2))

    (check-equal? (add (make-complex-from-real-imag 3 4)
                 (make-complex-from-real-imag 1 4))
            (make-complex-from-real-imag 4 8))
))

(run-tests sicp-02.78-tests)
