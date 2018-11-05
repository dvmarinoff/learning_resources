#lang racket

(require rackunit rackunit/text-ui)

(load "../60.rkt")

(define sicp-02.60-tests
  (test-suite
   "testing 02.60 sets as unordered-lists with duplication"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.60-tests)
