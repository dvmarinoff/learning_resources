#lang racket
;; ex 02.61
;; sets as ordered-lists adjoin-set
;;
;; Give an implementation of adjoin-set using the ordered
;; representation. By analogy with element-of-set? show how to
;; take advantage of the ordering to produce a procedure that
;; requires on the average about half as many steps as with the
;; unordered representation.

(define (adjoin-set x set)
  (cond ((null? set) (cons x set))
        ((< x (car set)) (cons x set))
        (else (cons
               (car set)
               (adjoin-set x (cdr set))))))

;;;;
;; Required code
;;;;
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else (element-of-set? x (cdr set)))))
