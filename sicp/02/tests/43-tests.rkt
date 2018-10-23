#lang racket

(require rackunit rackunit/text-ui)

(load "../43.rkt")

(define sicp-02.43-tests
  (test-suite
   "testing 02.43 time complexity analysis of eight-queens puzzle"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.43-tests)
