#lang racket

(require rackunit rackunit/text-ui)

(load "../07.rkt")

(define sicp-03.07-tests
  (test-suite
   "testing 03.07 make-joint procedure"

    (check-equal? (main 0) 0)
))

(run-tests sicp-03.07-tests)