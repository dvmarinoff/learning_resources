#lang racket

(require rackunit rackunit/text-ui)

(load "./23.rkt")

(define sicp-02.23-tests
  (test-suite
   "testing 02.23 for-each procedure"

    (check-equal? 1 1)
))

(run-tests sicp-02.23-tests)
