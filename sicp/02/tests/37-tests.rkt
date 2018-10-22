#lang racket

(require rackunit rackunit/text-ui)

(load "../37.rkt")

(define sicp-02.37-tests
  (test-suite
   "testing 02.37 matrix opperations"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.37-tests)
