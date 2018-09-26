#lang racket

(require rackunit rackunit/text-ui)

(load "../35.rkt")

(define sicp-01.35-tests
  (test-suite
   "testing 01.35 phi by fixed-point procedure"

    (check-equal? (main 0) 0)
))

(run-tests sicp-01.35-tests)
