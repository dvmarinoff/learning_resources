#lang racket

(require rackunit rackunit/text-ui)

(load "../41.rkt")

(define sicp-02.41-tests
  (test-suite
   "testing 02.41 find ordered triples <= n that sum to s"

   (check-equal? (ordered-triples-sum 3 6) '((3 2 1)))

   (check-equal? (unique-triples 3) '((3 2 1)))

   (check-true (sum-to? 0 '()))
   (check-true (sum-to? 1 '(1)))
   (check-true (sum-to? 10 '(1 2 3 4)))

   (check-equal? (sum '()) 0)
   (check-equal? (sum '(1)) 1)
   (check-equal? (sum '(1 2 3 4)) 10)
))

(run-tests sicp-02.41-tests)
