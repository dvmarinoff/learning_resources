#lang racket

(require rackunit rackunit/text-ui)

(load "../39.rkt")

(define sicp-02.39-tests
  (test-suite
   "testing 02.39 reverse in terms of fold"

    (check-equal? (reverse-r (list 1 4 9 16 25)) (list 25 16 9 4 1))
    (check-equal? (reverse-r (list 1 4)) (list 4 1))
    (check-equal? (reverse-r (list 1)) (list 1))
    (check-equal? (reverse-r '()) '())

    (check-equal? (reverse-l (list 1 4 9 16 25)) (list 25 16 9 4 1))
    (check-equal? (reverse-l (list 1 4)) (list 4 1))
    (check-equal? (reverse-l (list 1)) (list 1))
    (check-equal? (reverse-l '()) '())
))

(run-tests sicp-02.39-tests)
