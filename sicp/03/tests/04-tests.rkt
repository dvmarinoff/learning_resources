#lang racket

(require rackunit rackunit/text-ui)

(load "../04.rkt")

(define sicp-03.04-tests
  (test-suite
   "testing 03.04 add call-the-cops feature to make-account"

    (check-equal? (main 0) 0)
))

(run-tests sicp-03.04-tests)
