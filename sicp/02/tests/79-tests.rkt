#lang racket

(require rackunit rackunit/text-ui)

(load "../79.rkt")

(define sicp-02.79-tests
  (test-suite
   "testing 02.79 generic equality equ?"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.79-tests)
