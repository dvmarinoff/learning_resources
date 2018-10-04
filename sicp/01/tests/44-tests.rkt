#lang racket

(require rackunit rackunit/text-ui)

(load "./44.rkt")

(define sicp-01.44-tests
  (test-suite
   "testing 01.44 smooting procedure"

   ;; no idea how to test that
   (check-equal? ((smooth sqr) 4) 16.000000000066663)
))

(run-tests sicp-01.44-tests)
