#lang racket

(require rackunit rackunit/text-ui)

(load "../46.rkt")

(define sicp-02.46-tests
  (test-suite
   "testing 02.46 picture language 2d vectors"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.46-tests)
