(require rackunit rackunit/text-ui)
(load "./08.rkt")

(define sicp-1.8-tests
  (test-suite
   "Tests ex 1.8 cube root"

   (check-equal? (improve 3 27) 3)
   (check-equal? (improve 4 64) 4)
   (check-equal? (improve 5 125) 5)
   (check-equal?
    (exact->inexact (improve 5 27))
    3.6933333333333334)

   (check-equal? (good-enuf? 3 27) #t)
   (check-equal? (good-enuf? 4 64) #t)
   (check-equal? (good-enuf? 3.0 27) #t)
   (check-equal? (good-enuf? 4 27) #f)
   (check-equal? (good-enuf? (/ 9 4) 27) #f)
   (check-equal? (good-enuf? (+ (* tolerance tolerance) 3) 27) #t)

   (check-equal? (cube-root 3.0 27) 3.0)
   (check-= (cube-root 4.0 27) 3.0 tolerance)
   (check-= (cube-root 9.0 27) 3.0 tolerance)
   (check-= (cube-root 1.0 27) 3.0 tolerance)
))

(run-tests sicp-1.8-tests)
