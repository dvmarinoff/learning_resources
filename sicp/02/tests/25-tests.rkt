#lang racket

(require rackunit rackunit/text-ui)

(load "./25.rkt")

(define sicp-02.25-tests
  (test-suite
   "testing 02.25 combine car and cdr"

   (check-equal? (car (cdr (car (cdr (cdr '(1 3 (5 7) 9))))))
                 7)

   (check-equal? (car (car '((7))))
                 7)
   (check-equal?
    (cadr
     (cadr
      (cadr (cadr (cadr (cadr
                         '(1 (2 (3 (4 (5 (6 7))))))))))))
    7)
))

(run-tests sicp-02.25-tests)
