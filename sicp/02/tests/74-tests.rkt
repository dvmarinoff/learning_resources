#lang racket

(require rackunit rackunit/text-ui)

(load "./74.rkt")

(define sicp-02.74-tests
  (test-suite
   "testing 02.74 data-directed programming Insatiable Enterprises, Inc."

    (check-equal? (get-record-hurricanes "Baret" file1)
                  (car file1))

    (check-equal? (get-record-highlanders "Smith" file2)
                  (car file2))

    (check-equal? (get-record "Baret" hurricanes)
                  '("Baret" ((quote address) "Wellington 10"
                             (quote salary) 1000)))

    (check-equal? (get-record "Smith" highlanders)
                  '(("Smith") (((quote address) "Dunedin 15")
                              ((quote salary) 1000))))
))

(run-tests sicp-02.74-tests)
