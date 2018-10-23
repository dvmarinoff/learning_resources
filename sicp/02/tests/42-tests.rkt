#lang racket

(require rackunit rackunit/text-ui)

(load "../42.rkt")

(define sicp-02.42-tests
  (test-suite
   "testing 02.42 eight-queens puzzle"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.42-tests)
