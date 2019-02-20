#lang racket

(require rackunit rackunit/text-ui)

(load "./22.rkt")

(define sicp-03.22-tests
  (test-suite
   "testing 03.22 queue with local state"

   (test-begin "queue"
     (define q1 (make-queue))
     (check-equal? ((q1 'insert) 'a) (list 'a))
     (check-equal? ((q1 'insert) 'b) (list 'a 'b))
     (check-equal? ((q1 'insert) 'c) (list 'a 'b 'c))
     (check-equal? (q1 'delete)      (list 'b 'c))
     (check-equal? ((q1 'insert) 'd) (list 'b 'c 'd)))
))

(run-tests sicp-03.22-tests)
