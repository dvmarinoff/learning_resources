#lang racket

(require rackunit rackunit/text-ui)

(load "../36.rkt")

(define sicp-02.36-tests
  (test-suite
   "testing 02.36 accumulate-n procedure"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.36-tests)
