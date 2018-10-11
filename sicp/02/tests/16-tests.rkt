#lang racket

(require rackunit rackunit/text-ui)

(load "../16.rkt")

(define sicp-02.16-tests
  (test-suite
   "testing 02.16 interval arithmetic devise a better package"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.16-tests)
