#lang racket

(require rackunit rackunit/text-ui)

(load "./05.rkt")

(define sicp-02.05-tests
  (test-suite
   "testing 02.05 representing pairs of numbers with 2^a * 3^b"

   (check-equal? (car (cons 1 2)) 1)
   (check-equal? (car (cons 2 2)) 2)
   (check-equal? (car (cons 3 2)) 3)
   (check-equal? (car (cons 4 1)) 4)
   (check-equal? (car (cons 4 3)) 4)
   (check-equal? (car (cons 4 5)) 4)
   (check-equal? (car (cons 4 8)) 4)

   (check-equal? (cdr (cons 1 2)) 2)
   (check-equal? (cdr (cons 2 2)) 2)
   (check-equal? (cdr (cons 3 2)) 2)
   (check-equal? (cdr (cons 4 1)) 1)
   (check-equal? (cdr (cons 4 3)) 3)
   (check-equal? (cdr (cons 4 5)) 5)
   (check-equal? (cdr (cons 4 8)) 8)

   (check-equal? (guess-a (cons 2 3) 3) 2.0)
   (check-equal? (guess-a (cons 3 3) 3) 3.0)
   (check-equal? (guess-a (cons 4 5) 5) 4.0)
))

(run-tests sicp-02.05-tests)
