#lang racket

(require rackunit rackunit/text-ui)

(load "../30.rkt")

(define sicp-02.30-tests
  (test-suite
   "testing 02.30 binary mobile square-tree procedure"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.30-tests)
