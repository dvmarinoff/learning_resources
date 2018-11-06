#lang racket
;; ex 02.62
;; sets as ordered-lists union-set in O(n)
;;
;; Give a Θ(n) implementation of union-set for sets represented
;; as ordered lists

(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else (sort-set (append set1 set2)))))

(define (sort-set set)
  (cond ((null? set) set)
        (else (adjoin-set
               (car set)
               (sort-set (cdr set))))))

(define (intersection-set set1 set2)
  (filter (lambda (x) (element-of-set? x set1)) set2))

;;;;
;; Required code
;;;;
(define (adjoin-set x set)
  (cond ((null? set) (cons x set))
        ((< x (car set)) (cons x set))
        (else (cons
               (car set)
               (adjoin-set x (cdr set))))))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else (element-of-set? x (cdr set)))))
