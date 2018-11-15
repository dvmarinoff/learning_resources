#lang racket

(require rackunit rackunit/text-ui)

(load "../76.rkt")

(define sicp-02.76-tests
  (test-suite
   "testing 02.76 compare the 3 strategies for systems with generic operations"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.76-tests)
