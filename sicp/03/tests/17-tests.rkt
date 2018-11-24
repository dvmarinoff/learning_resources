#lang racket

(require rackunit rackunit/text-ui)

(load "./17.rkt")

(define sicp-03.17-tests
  (test-suite
   "testing 03.17 write count-pairs that works"

    (check-equal? (count-pairs three) 3)
    (check-equal? (count-pairs four) 3)
    (check-equal? (count-pairs seven) 3)
))

(run-tests sicp-03.17-tests)
