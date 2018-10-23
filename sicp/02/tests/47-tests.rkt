#lang racket

(require rackunit rackunit/text-ui)

(load "../47.rkt")

(define sicp-02.47-tests
  (test-suite
   "testing 02.47 picture language implement frames"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.47-tests)
