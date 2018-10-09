#lang racket

(require rackunit rackunit/text-ui)

(load "./04.rkt")

(define sicp-02.04-tests
  (test-suite
   "testing 02.04 alternative procedural representation of pairs"

    (check-equal? (car (cons 1 4)) 1)
    (check-equal? (cdr (cons 1 4)) 4)

    (check-equal? ((car (cons (lambda (x) 1)
                              (lambda (x) 2))) 3) 1)
    (check-equal? ((cdr (cons (lambda (x) 1)
                              (lambda (x) 2))) 3) 2)

    (check-equal? (car (cons '(1) '(4))) '(1))
    (check-equal? (cdr (cons '(1) '(4))) '(4))

    (check-equal? (car (list (cons 1 2) (cons 3 4))) (cons 1 2))
))

(run-tests sicp-02.04-tests)
