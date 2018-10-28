#lang racket

(require rackunit rackunit/text-ui)

(load "./54.rkt")

(define sicp-02.54-tests
  (test-suite
   "testing 02.54 equal? procedure"

   (check-true (my-equal? a a) "equal? a a")
   (check-true (my-equal? b b) "equal? b b")
   (check-true (my-equal? d d) "equal? d d")
   (check-true (my-equal? e e) "equal? e e")
   (check-false (my-equal? a b) "equal? a b")
   (check-false (my-equal? b a) "equal? b a")
   (check-false (my-equal? d e) "equal? d e")
   (check-false (my-equal? e a) "equal? e a")
))

(run-tests sicp-02.54-tests)
