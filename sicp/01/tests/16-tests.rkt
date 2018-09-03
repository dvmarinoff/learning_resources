(require rackunit rackunit/text-ui)

(load "./16.rkt")

(define sicp-1.16-tests
  (test-suite
   "testing ex 1.16 fast exponentiation with iterative process in log n time"

   (check-equal? (fast-expt 2 0) 1)
   (check-equal? (fast-expt 2 1) 2)
   (check-equal? (fast-expt 2 3) 8)
   (check-equal? (fast-expt 2 4) 16)
   (check-equal? (fast-expt 2 5) 32)
   (check-equal? (fast-expt 4 3) 64)
   (check-equal? (fast-expt 4 4) 256)
   (check-equal? (fast-expt 4 8) 65536)
   (check-equal? (fast-expt 4 9) 262144)
   (check-equal? (fast-expt 4 18) 68719476736)

   ))

(run-tests sicp-1.16-tests)
