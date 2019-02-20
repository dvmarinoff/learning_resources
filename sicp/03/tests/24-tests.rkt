#lang racket

(require rackunit rackunit/text-ui)

(load "../24.rkt")

(define sicp-03.24-tests
  (test-suite
   "testing 03.24 make-table procedure"

    (check-equal? (main 0) 0)
))

(run-tests sicp-03.24-tests)
