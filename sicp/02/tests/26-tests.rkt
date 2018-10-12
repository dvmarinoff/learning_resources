#lang racket

(require rackunit rackunit/text-ui)

(load "../26.rkt")

(define sicp-02.26-tests
  (test-suite
   "testing 02.26 examine append, cons and list differences"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.26-tests)
