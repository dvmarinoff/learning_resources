(require rackunit rackunit/text-ui)
(load "./12.rkt")

(define sicp-1.12-tests
  (test-suite
   "tests 1.12 pascal's triangle"

   (check-equal? (pascal 1 1) 1)
   (check-equal? (pascal 2 1) 1)
   (check-equal? (pascal 2 2) 1)
   (check-equal? (pascal 3 1) 1)
   (check-equal? (pascal 3 2) 2)
   (check-equal? (pascal 3 3) 1)
   (check-equal? (pascal 4 1) 1)
   (check-equal? (pascal 4 2) 3)
   (check-equal? (pascal 4 3) 3)
   (check-equal? (pascal 4 4) 1)
   (check-equal? (pascal 5 1) 1)
   (check-equal? (pascal 5 2) 4)
   (check-equal? (pascal 5 3) 6)
   (check-equal? (pascal 5 2) 4)
   (check-equal? (pascal 5 1) 1)

   (check-equal? (fact 1) 1)
   (check-equal? (fact 3) 6)
   (check-equal? (fact 4) 24)
   (check-equal? (fact 5) 120)
   ))

(run-tests sicp-1.12-tests)
