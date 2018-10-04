#lang racket

(require rackunit rackunit/text-ui)

(load "../43.rkt")

(define sicp-01.43-tests
  (test-suite
   "testing 01.43 repeated applicaion procedure"

    (check-equal? ((repeated sqr 2) 5) 625)

    (check-equal? ((repeated-compose sqr 2) 5) 625)
))

(run-tests sicp-01.43-tests)
