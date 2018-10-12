#lang racket

(require rackunit rackunit/text-ui)

(load "../31.rkt")

(define sicp-02.31-tests
  (test-suite
   "testing 02.31 binary mobile extend-tree procedure"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.31-tests)
