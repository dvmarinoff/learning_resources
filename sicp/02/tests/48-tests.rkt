#lang racket

(require rackunit rackunit/text-ui)

(load "../48.rkt")

(define sicp-02.48-tests
  (test-suite
   "testing 02.48 picture language implement segments through vectors"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.48-tests)
