#lang racket

(require rackunit rackunit/text-ui)

(load "./38.rkt")

(define sicp-01.38-tests
  (test-suite
   "testing 01.38 approximate e based on Euler's expansion"

   (check-equal? (series-term 1) 1)
   (check-equal? (series-term 2) 2)
   (check-equal? (series-term 3) 1)
   (check-equal? (series-term 4) 1)
   (check-equal? (series-term 5) 4)
   (check-equal? (series-term 6) 1)
   (check-equal? (series-term 7) 1)
   (check-equal? (series-term 8) 6)
   (check-equal? (series-term 9) 1)
   (check-equal? (series-term 10) 1)
   (check-equal? (series-term 11) 8)
   (check-equal? (series-term 12) 1)
   (check-equal? (series-term 13) 1)
   (check-equal? (series-term 14) 10)
   (check-equal? (series-term 15) 1)
   (check-equal? (series-term 16) 1)
   (check-equal? (series-term 17) 12)

   (check-= (approximate-eulers-number 30) eulers-number (expt 10 -10))
))

(run-tests sicp-01.38-tests)
