#lang racket

(require rackunit rackunit/text-ui)

(load "./46.rkt")

(define sicp-01.46-tests
  (test-suite
   "testing 01.46 iterative improve procedure"

    (check-= (sqrt 9) 3 0.0000001)
    (check-= (sqrt 256) 16 0.0000001)
    (check-= (fixed-point cos 1.0) 0.739084 0.00001)
))

(run-tests sicp-01.46-tests)
