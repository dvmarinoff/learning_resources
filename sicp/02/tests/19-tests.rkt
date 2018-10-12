#lang racket

(require rackunit rackunit/text-ui)

(load "../19.rkt")

(define sicp-02.19-tests
  (test-suite
   "testing 02.19 extend change-counting with lists"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.19-tests)
