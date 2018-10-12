#lang racket

(require rackunit rackunit/text-ui)

(load "../17.rkt")

(define sicp-02.17-tests
  (test-suite
   "testing 02.17 last-pair procedure"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.17-tests)
