(require rackunit rackunit/text-ui)

(load "./19.rkt")

(define sicp-1.19-tests
  (test-suite
   "testing 1.19 logarithmic fibonacii"

   (check-equal? (fib 0) 0)
   (check-equal? (fib 1) 1)
   (check-equal? (fib 2) 1)
   (check-equal? (fib 3) 2)
   (check-equal? (fib 4) 3)
   (check-equal? (fib 5) 5)
   (check-equal? (fib 6) 8)
   (check-equal? (fib 7) 13)
   (check-equal? (fib 8) 21)
))

(run-tests sicp-1.19-tests)
