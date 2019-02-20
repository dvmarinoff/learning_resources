#lang racket

(require rackunit rackunit/text-ui)

(load "../50.rkt")

(define sicp-03.50-tests
  (test-suite
   "testing 03.50 stream-map procedure"

    (check-equal? (main 0) 0)
))

(run-tests sicp-03.50-tests)
