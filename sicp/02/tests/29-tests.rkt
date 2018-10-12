#lang racket

(require rackunit rackunit/text-ui)

(load "../29.rkt")

(define sicp-02.29-tests
  (test-suite
   "testing 02.29 a binary mobile"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.29-tests)
