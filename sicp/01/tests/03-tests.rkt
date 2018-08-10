(require rackunit rackunit/text-ui)
(load "../03.rkt")

(define sicp-1.3-tests
  (test-suite
   "Test ex 1.3 sum of largest squares"

   (check-equal? (largest-sum-of-squares 2 3 4) 25)
   (check-equal? (largest-sum-of-squares 3 2 4) 25)
   (check-equal? (largest-sum-of-squares 4 2 3) 25)
   (check-equal? (largest-sum-of-squares 4 3 2) 25)

   (check-equal? (largest-sum-of-squares 3 3 4) 25)
   (check-equal? (largest-sum-of-squares 4 3 3) 25)

   (check-equal? (largest-sum-of-squares 4 4 3) 32)
   (check-equal? (largest-sum-of-squares 4 4 4) 32)))

(run-tests sicp-1.3-tests)
