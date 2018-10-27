#lang racket

(require rackunit rackunit/text-ui)

(load "../51.rkt")

(define sicp-02.51-tests
  (test-suite
   "testing 02.51 picture language below painter"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.51-tests)
