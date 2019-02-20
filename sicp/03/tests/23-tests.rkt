#lang racket

(require rackunit rackunit/text-ui)

(load "./23.rkt")

(define sicp-03.23-tests
  (test-suite
   "testing 03.23 a dequeue data structure"

   (begin-test "make-dequeue"
    (check-equal? (make-dequeue) (cons '() '())))
   (begin-test "empty-dequeue?"
    (check-true (empty-dequeue? (make-dequeue))))
   (begin-test "front-dequeue"
    (define q1 (make-dequeue))
    (check-equal? (front-dequeue q1) (list 'a)))
   (begin-test "rear-dequeue"
    (define q1 (make-dequeue))
    (check-equal? (front-dequeue q1) (list 'a)))
   (begin-test "insert-dequeue"
    (define q1 (make-dequeue))
    (check-equal? (insert-dequeue q1 'a) (list 'a))
    (check-equal? (insert-dequeue q1 'b) (list 'a 'b)))
))

(run-tests sicp-03.23-tests)
