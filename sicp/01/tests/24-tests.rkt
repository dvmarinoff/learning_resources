#lang racket

(require rackunit rackunit/text-ui)

(load "../24.rkt")

(define sicp-01.24-tests
  (test-suite
   "testing 01.24 modify timed-prime-test to use fermat test"

    (check-equal? (main 0) 0)
))

(run-tests sicp-01.24-tests)
