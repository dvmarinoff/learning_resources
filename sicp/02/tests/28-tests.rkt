#lang racket

(require rackunit rackunit/text-ui)

(load "../28.rkt")

(define sicp-02.28-tests
  (test-suite
   "testing 02.28 fringe procedure"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.28-tests)
