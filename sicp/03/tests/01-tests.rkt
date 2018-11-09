#lang racket

(require rackunit rackunit/text-ui)

(load "../01.rkt")

(define sicp-03.01-tests
  (test-suite
   "testing 03.01 make-accumulator procedure"

   (check-equal? (make-accumulator 0) 0)
))

(run-tests sicp-03.01-tests)
