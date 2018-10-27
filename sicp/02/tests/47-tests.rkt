#lang racket

(require rackunit rackunit/text-ui)

(load "./47.rkt")

(define sicp-02.47-tests
  (test-suite
   "testing 02.47 picture language implement frames"

   (check-equal? (origin-frame (make-frame1 (make-vect 0 0)
                                            (make-vect 2 4)
                                            (make-vect 3 1)))
                 (make-vect 0 0))
   (check-equal? (edge1-frame (make-frame1 (make-vect 0 0)
                                            (make-vect 2 4)
                                            (make-vect 3 1)))
                 (make-vect 2 4))
   (check-equal? (edge2-frame (make-frame1 (make-vect 0 0)
                                           (make-vect 2 4)
                                           (make-vect 3 1)))
                 (make-vect 3 1))

   (check-equal? (origin-frame2 (make-frame2 (make-vect 0 0)
                                            (make-vect 2 4)
                                            (make-vect 3 1)))
                 (make-vect 0 0))
   (check-equal? (edge1-frame2 (make-frame2 (make-vect 0 0)
                                           (make-vect 2 4)
                                           (make-vect 3 1)))
                 (make-vect 2 4))
   (check-equal? (edge2-frame2 (make-frame2 (make-vect 0 0)
                                           (make-vect 2 4)
                                           (make-vect 3 1)))
                 (make-vect 3 1))
))

(run-tests sicp-02.47-tests)
