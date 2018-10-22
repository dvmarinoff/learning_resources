#lang racket

(require rackunit rackunit/text-ui)

(load "../38.rkt")

(define sicp-02.38-tests
  (test-suite
   "testing 02.38 expole fold-left and fold-right"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.38-tests)
