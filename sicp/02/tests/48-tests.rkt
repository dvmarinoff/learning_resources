#lang racket

(require rackunit rackunit/text-ui)

(load "./48.rkt")

(define sicp-02.48-tests
  (test-suite
   "testing 02.48 picture language implement segments through vectors"

   (check-equal? (make-segment (make-vect 2 2)
                               (make-vect 4 2))
                 (cons (cons 2 2) (cons 4 2)))
   (check-equal? (start-segment (make-segment (make-vect 2 2)
                                              (make-vect 4 2)))
                 (make-vect 2 2))
   (check-equal? (end-segment (make-segment (make-vect 2 2)
                                              (make-vect 4 2)))
                 (make-vect 4 2))
))

(run-tests sicp-02.48-tests)
