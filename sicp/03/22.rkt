#lang racket
;; ex 03.22
;; queue with local state
;;
;; Instead of representing a queue as a pair of pointers, we can
;; build a queue as a procedure with local state. The local state
;; will consist of pointers to the beginning and the end of an
;; ordinary list.Thus, the make-queue procedure will have the form
;;
;; (define (make-queue)
;;   (let ((front-ptr ...)
;;         (rear-ptr ...))
;;     <definitions of internal procedures>
;;     (define (dispatch m) ...)
;;     dispatch))
;;
;; Complete the definition of make-queue and provide
;; implementations of the queue operations using this representation.

(require r5rs/init)

(define (make-queue)
  (define front-ptr '())
  (define rear-ptr '())
  (define (empty?)
    (null? front-ptr))
  (define (front)
    (if (empty?)
        (error "FRONT called with an empty queue")
        (car front-ptr)))

  (define (insert item)
    (let ((new-pair (cons item '())))
      (cond ((empty?)
             (set! front-ptr new-pair)
             (set! rear-ptr new-pair)
             front-ptr)
            (else
             (set-cdr! rear-ptr new-pair)
             (set! rear-ptr new-pair)
             front-ptr))))
  (define (delete)
    (cond ((empty?)
           (error "DELETE called on empty queue"))
          (else
           (set! front-ptr (cdr front-ptr))
           front-ptr)))

  (define (print)
    (display (format "<#queue~a>" front-ptr)))

  (define (dispatch m)
    (cond ((eq? m 'insert) insert)
          ((eq? m 'delete) (delete))
          ((eq? m 'print) (print))
          (else (error "QUEUE unknown operation" m))))
    dispatch)

(define q1 (make-queue))
((q1 'insert) 'a)
((q1 'insert) 'b)
((q1 'insert) 'c)
((q1 'insert) 'd)
(q1 'print)
