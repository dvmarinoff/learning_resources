#lang racket

(require rackunit rackunit/text-ui)

(load "./20.rkt")

(define sicp-02.20-tests
  (test-suite
   "testing 02.20 same-parity procedure"

   (check-equal? (same-parity 1 2 3 4 5 6 7) (list 1 3 5 7))
   (check-equal? (same-parity 2 3 4 5 6 7) (list 2 4 6))
))

(run-tests sicp-02.20-tests)
