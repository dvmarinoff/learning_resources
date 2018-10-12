#lang racket

(require rackunit rackunit/text-ui)

(load "../25.rkt")

(define sicp-02.25-tests
  (test-suite
   "testing 02.25 combine car and cdr"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.25-tests)
