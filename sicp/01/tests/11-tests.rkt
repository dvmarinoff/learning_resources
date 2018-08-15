(require rackunit rackunit/text-ui)
(load "./11.rkt")

(define sicp-11-tests
  (test-suite
   "Tests ex 11 recursive and iterative process implementation"

   (check-equal? (fib-recur 0) 0)
   (check-equal? (fib-recur 1) 1)
   (check-equal? (fib-recur 2) 2)
   (check-equal? (fib-recur 3) 4)
   (check-equal? (fib-recur 4) 11)
   (check-equal? (fib-recur 5) 25)

   (check-equal? (fib-iter 0) 0)
   (check-equal? (fib-iter 1) 1)
   (check-equal? (fib-iter 2) 2)
   (check-equal? (fib-iter 3) 4)
   (check-equal? (fib-iter 4) 11)
   (check-equal? (fib-iter 5) 25)
))

(run-tests sicp-11-tests)
