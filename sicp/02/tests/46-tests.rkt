#lang racket

(require rackunit rackunit/text-ui)

(load "./46.rkt")

(define sicp-02.46-tests
  (test-suite
   "testing 02.46 picture language 2d vectors"

   (check-equal? (add-vect (make-vect 2 2)
                           (make-vect 4 2))
                 (make-vect 6 4))

   (check-equal? (sub-vect (make-vect 2 2)
                           (make-vect 4 2))
                 (make-vect -2 0))

   (check-equal? (scale-vect 2 (make-vect 2 2))
                 (make-vect 4 4))
))

(run-tests sicp-02.46-tests)
