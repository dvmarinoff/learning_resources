#lang racket

(require rackunit rackunit/text-ui)

(load "../21.rkt")

(define sicp-02.21-tests
  (test-suite
   "testing 02.21 square-list procedure"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.21-tests)
