#lang racket

(require rackunit rackunit/text-ui)

(load "./36.rkt")

(define sicp-02.36-tests
  (test-suite
   "testing 02.36 accumulate-n procedure"

   (check-equal? (accumulate-n + 0
                  '((1 2 3) (4 5 6) (7 8 9) (10 11 12)))
                 '(22 26 30))
))

(run-tests sicp-02.36-tests)
