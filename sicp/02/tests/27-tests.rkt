#lang racket

(require rackunit rackunit/text-ui)

(load "../27.rkt")

(define sicp-02.27-tests
  (test-suite
   "testing 02.27 deep-reverse procedure"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.27-tests)
