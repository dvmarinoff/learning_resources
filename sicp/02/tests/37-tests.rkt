#lang racket

(require rackunit rackunit/text-ui)

(load "./37.rkt")

(define sicp-02.37-tests
  (test-suite
   "testing 02.37 matrix opperations"

    (check-equal?
     (matrix-*-vector '((1 2)
                        (3 4))
                      '(5 6))
     '(17 39))

    (check-equal?
     (transpose '((1 2 3)
                  (4 5 6)
                  (7 8 9)))
     '((1 4 7)
       (2 5 8)
       (3 6 9)))

    (check-equal?
     (matrix-*-matrix '((1 2)
                        (3 4))
                      '((5 6)
                        (7 8)))
     '((19 22)
       (43 50)))
))

(run-tests sicp-02.37-tests)
