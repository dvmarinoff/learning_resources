#lang racket

(require rackunit rackunit/text-ui)

(load "../50.rkt")

(define sicp-02.50-tests
  (test-suite
   "testing 02.50 picture language flip and rotation painters"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.50-tests)
