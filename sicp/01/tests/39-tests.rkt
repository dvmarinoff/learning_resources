#lang racket

(require rackunit rackunit/text-ui)

(load "./39.rkt")

(define sicp-01.39-tests
  (test-suite
   "testing 01.39 tangent approximation by Lambert's formula"

   (check-equal? (d-term 1) 1)
   (check-equal? (d-term 2) 3)
   (check-equal? (d-term 3) 5)
   (check-equal? (d-term 4) 7)
   (check-equal? (d-term 5) 9)
   (check-equal? (d-term 6) 11)
   (check-equal? (d-term 7) 13)
   (check-equal? (d-term 8) 15)
   (check-equal? (d-term 9) 17)
   (check-equal? (d-term 10) 19)

   (check-equal? ((n-term 2) 1) 2)
   (check-equal? ((n-term 2) 2) 4)
   (check-equal? ((n-term 2) 3) 4)
   (check-equal? ((n-term 2) 4) 4)

   (check-= (tan 1.0) (tan-cf 1.0 10) (expt 10.0 -10) "tan-cf 1.0")
   (check-= (tan 2.0) (tan-cf 2.0 10) (expt 10.0 -10) "tan-cf 2.0")
   (check-= (tan 3.0) (tan-cf 3.0 10) (expt 10.0 -9) "tan-cf 3.0")
   (check-= (tan 4.0) (tan-cf 4.0 10) (expt 10.0 -6) "tan-cf 4.0")
))

(run-tests sicp-01.39-tests)
