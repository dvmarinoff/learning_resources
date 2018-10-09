#lang racket

(require rackunit rackunit/text-ui)

(load "./03.rkt")

(define sicp-02.03-tests
  (test-suite
   "testing 02.03 representing rectangles in a plane"

    (check-equal? (segment-length (make-segment
                                   (make-point 0 1)
                                   (make-point 4 4))) 5)

    (check-equal? (segment-length (make-segment
                                   (make-point 1 0)
                                   (make-point 4 4))) 5)

    (check-equal? (segment-length (make-segment
                                   (make-point 4 0)
                                   (make-point 4 4))) 4)

    (check-equal? (segment-length (make-segment
                                   (make-point 0 0)
                                   (make-point 4 4))) (sqrt 32))

    (check-equal? (area (make-rect (make-rect-side 0 0 0 4)
                                   (make-rect-side 0 0 4 0)
                                   (make-rect-side 4 0 4 4)
                                   (make-rect-side 4 4 0 4))) 16)
))

(run-tests sicp-02.03-tests)
