(require rackunit rackunit/text-ui)

(load "./17.rkt")

(define sicp-1.17-tests
  (test-suite
   "testing 1.17 logarithmic multiplication"

   (check-equal? (mul 2 0) 0)
   (check-equal? (mul 2 1) 2)
   (check-equal? (mul 2 2) 4)
   (check-equal? (mul 2 3) 6)
   (check-equal? (mul 0 4) 0)
   (check-equal? (mul 1 4) 4)
   (check-equal? (mul 2 4) 8)
   (check-equal? (mul 3 4) 12)

   ))

(run-tests sicp-1.17-tests)
