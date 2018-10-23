#lang racket

(require rackunit rackunit/text-ui)

(load "./33.rkt")

(define sicp-02.33-tests
  (test-suite
   "testing 02.33 seq methods with fold (accumulation)"

    (check-equal? (map inc '(1 2 3 4)) '(2 3 4 5))
    (check-equal? (append '(1 2) '(3 4)) '(1 2 3 4))
    (check-equal? (length '(1 2 3 4)) 4)

))

(run-tests sicp-02.33-tests)
