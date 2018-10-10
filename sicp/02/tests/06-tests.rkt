#lang racket

(require rackunit rackunit/text-ui)

(load "./06.rkt")

(define sicp-02.06-tests
  (test-suite
   "testing 02.06 Church numerals"

    (check-equal? ((one inc) 1) 2)
    (check-equal? ((two inc) 2) 4)
    (check-equal? (((f+ one two) inc) 1) 4)
    (check-equal? (((f+ one two) inc) 2) 5)
))

(run-tests sicp-02.06-tests)
