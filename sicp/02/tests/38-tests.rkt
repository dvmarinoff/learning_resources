#lang racket

(require rackunit rackunit/text-ui)

(load "./38.rkt")

(define sicp-02.38-tests
  (test-suite
   "testing 02.38 explore fold-left and fold-right"

   (check-equal? (fold-right + 0 (list 1 2 3))
                 (fold-left + 0 (list 1 2 3)))

   (check-equal? (fold-right * 1 (list 1 2 3))
                 (fold-left * 1 (list 1 2 3)))
))

(run-tests sicp-02.38-tests)
