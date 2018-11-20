#lang racket

(require rackunit rackunit/text-ui)

(load "../01.rkt")

(define sicp-03.01-tests
  (test-suite
   "testing 03.01 make-accumulator procedure"

   (check-equal? ((make-accumulator 0) 0) 0)
   (check-equal? ((make-accumulator 0) 1) 1)
   (check-equal? ((make-accumulator 1) 0) 1)
   (check-equal? ((make-accumulator 3) 4) 7)
   (check-equal? ((make-accumulator 5) 10) 15)
))

(run-tests sicp-03.01-tests)
