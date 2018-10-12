#lang racket

(require rackunit rackunit/text-ui)

(load "../20.rkt")

(define sicp-02.20-tests
  (test-suite
   "testing 02.20 same-parity procedure"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.20-tests)
