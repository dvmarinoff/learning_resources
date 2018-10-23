#lang racket

(require rackunit rackunit/text-ui)

(load "../44.rkt")

(define sicp-02.44-tests
  (test-suite
   "testing 02.44 picture language up-split procedure"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.44-tests)
