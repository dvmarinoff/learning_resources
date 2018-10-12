#lang racket

(require rackunit rackunit/text-ui)

(load "./17.rkt")

(define sicp-02.17-tests
  (test-suite
   "testing 02.17 last-pair procedure"

   (check-equal? (last-pair (list 23 72 149 34)) (list 34))
   (check-equal? (last-pair (list 34)) (list 34))
   (check-equal? (last-pair '()) '())
))

(run-tests sicp-02.17-tests)
