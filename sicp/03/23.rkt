#lang racket
;; ex 03.23
;; a dequeue data structure
;;
;; A deque (``double-ended queue'') is a sequence in which items
;; can be inserted and deleted at either the front or the rear.
;; Operations on deques are the constructor make-deque, the
;; predicate empty-deque?, selectors front-deque and rear-deque,
;; and mutators front-insert- deque!, rear-insert-deque!,
;; front-delete-deque!, and rear-delete-deque!. Show how to
;; represent deques using pairs, and give implementations of the
;; operations. 23 All operations should be accomplished in (1) steps.

(define (make-dequeue) (cons '() '()))
(define (empty-dequeue? dequeue) (null? (front-dequeue dequeue)))
(define (front-dequeue dequeue)
  (cond ((empty-dequeue? dequeue)
         (error "FRONT called on empty dequeue"))
        (else
         ())))
(define (rear-dequeue dequeue) ())
(define (front-insert-dequeue! dequeue) ())
(define (rear-insert-dequeue! dequeue) ())
(define (front-delete-dequeue! dequeue) ())
(define (rear-delete-dequeue! dequeue) ())
(define (prn dequeue)
  (display (format "<#dequeue~a>" (front-dequeue dequeue))))

;; (define (dequeue)
;;   ())
