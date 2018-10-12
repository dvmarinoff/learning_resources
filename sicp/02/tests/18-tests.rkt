#lang racket

(require rackunit rackunit/text-ui)

(load "../18.rkt")

(define sicp-02.18-tests
  (test-suite
   "testing 02.18 reverse procedure"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.18-tests)
