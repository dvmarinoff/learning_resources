#lang racket

(require rackunit rackunit/text-ui)

(load "../02.rkt")

(define sicp-03.02-tests
  (test-suite
   "testing 03.02 make-monitored procedure"

   (check-equal? (make-monitored sqrt) null)
   (check-equal? (s 100) 10)
   (check-equal? (s 'how-many-calls?) 1)
))

(run-tests sicp-03.02-tests)
