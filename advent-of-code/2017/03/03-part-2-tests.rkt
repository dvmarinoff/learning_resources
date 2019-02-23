#lang racket

(require rackunit rackunit/text-ui)

(load "./03-part-2.rkt")

(define aoc.2017.03p2-tests
  (test-suite
   "testing 2017.03 Spiral memory"

   (check-equal? (search-side-size 7) 3)
   (check-equal? (search-side-size 9) 3)
   (check-equal? (search-side-size 10) 5)
   (check-equal? (search-side-size 25) 5)
   (check-equal? (search-side-size 28) 7)
   (check-equal? (search-side-size 70) 9)

   (check-equal? (search-distance 361527) 326 "answer")

   ))

(run-tests aoc.2017.03p1-tests)
