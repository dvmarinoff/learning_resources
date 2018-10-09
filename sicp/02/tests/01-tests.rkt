#lang racket

(require rackunit rackunit/text-ui)

(load "./01.rkt")

(define sicp-02.01-tests
  (test-suite
   "testing 02.01 better make-rat"

   (check-equal? (make-rat 3 -6) (cons -1 2))
   (check-equal? (make-rat -3 -6) (cons 1 2))
   (check-equal? (make-rat -3 6) (cons -1 2))
))

(run-tests sicp-02.01-tests)
