#lang racket

(require rackunit rackunit/text-ui)

(load "../25.rkt")

(define sicp-01.25-tests
  (test-suite
   "testing 01.25 explain Alyssa's expmod procedure"

    (check-equal? (main 0) 0)
))

(run-tests sicp-01.25-tests)
