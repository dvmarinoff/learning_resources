#lang racket

(require rackunit rackunit/text-ui)

(load "../02.rkt")

(define s (make-monitored sqrt))

(define sicp-03.02-tests
  (test-suite
   "testing 03.02 make-monitored procedure"

   (check-equal? (begin (s 100)
                        (s 100)
                        (s 100)
                        (s 'how-many-calls?)) 3)

   (check-equal? (begin (s 'reset-count)
                        (s 'how-many-calls?)) 0)
))

(run-tests sicp-03.02-tests)
