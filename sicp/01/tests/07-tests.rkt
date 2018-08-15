(require rackunit rackunit/text-ui)
(load "07.rkt")

(define sicp-1.7-tests
  (test-suite
   "Tests ex 1.7 sqrt precision"

   (check-= (sqrt 4e-8) 2e-4 1e-16)
   (check-= (* (sqrt 10e+48) (sqrt 10e+48)) 10e+48 10e+33)
   ))

(run-tests sicp-1.7-tests)
