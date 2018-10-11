#lang racket

(require rackunit rackunit/text-ui)

(load "./14.rkt")

(define sicp-02.14-tests
  (test-suite
   "testing 02.14 interval arithmetic inestigate Lem's bug report"

    (check-= (upper-bound a-over-a) 1 0.106)
    (check-= (lower-bound a-over-a) 1 0.105)
))

(run-tests sicp-02.14-tests)
