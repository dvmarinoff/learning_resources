#lang racket

(require rackunit rackunit/text-ui)

(load "./18.rkt")

(define sicp-03.18-tests
  (test-suite
   "testing 03.18 find cycle procedure"

    (check-true (cycle-structure cycle))
    (check-false (cycle-structure three))
    ;; (check-equal? (cycle-structure four) 3)
    ;; (check-equal? (cycle-structure seven) 3)
))

(run-tests sicp-03.18-tests)
