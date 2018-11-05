#lang racket
;; ex 02.59
;; sets as unordered-lists union-set
;;
;; Implement the union-set operation for the unordered-list
;; representation of sets.

(define (union-set set1 set2)
  (foldr (lambda (x acc) (cons x acc)) set2 set1))

(define (union-set2 set1 set2)
  (define (recur set1 set2 u)
    (cond ((and (null? set1) (null? set2)) u)
          ((pair? set2)
           (recur set1 (cdr set2) (cons (car set2) u)))
          ((pair? set1)
           (recur (cdr set1) set2 (cons (car set1) u)))))
  (recur set1 set2 '()))

