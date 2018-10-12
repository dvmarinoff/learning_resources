#lang racket

(require rackunit rackunit/text-ui)

(load "./18.rkt")

(define sicp-02.18-tests
  (test-suite
   "testing 02.18 reverse procedure"

   (check-equal? (reverse (list 1 4 9 16 25)) (list 25 16 9 4 1))
   (check-equal? (reverse (list 1 4)) (list 4 1))
   (check-equal? (reverse (list 1)) (list 1))
   (check-equal? (reverse '()) '())
))

(run-tests sicp-02.18-tests)
