#lang racket

(require rackunit rackunit/text-ui)

(load "../35.rkt")

(define sicp-02.35-tests
  (test-suite
   "testing 02.35 count-leaves as accumulation"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.35-tests)
