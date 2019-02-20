#lang racket
;; ex 02.59
;; sets as unordered-lists union-set
;;
;; Implement the union-set operation for the unordered-list
;; representation of sets.

;; Note:
;; first implementation preserves order, but does not remove
;; duplicates from both sets, just from one set:
;; (union-set (1) (1 2 2))
;; must be (1 2), but it is (1 2 2)
(define (union-set set1 set2)
  (foldr (lambda (x acc) (adjoin-set x acc)) set2 set1))

;; does not preserve order (as is by requirement) and
;; works on sets with duplication
(define (union-set set1 set2)
  (define (recur set1 set2 u)
    (cond ((and (null? set1) (null? set2)) u)
          ((pair? set2)
           (recur set1 (cdr set2) (adjoin-set (car set2) u)))
          ((pair? set1)
           (recur (cdr set1) set2 (adjoin-set (car set1) u)))))
  (recur set1 set2 '()))


;;;;
;; Required code
;;;;
(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((equal? (car set) x) #t)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set x set)
      set
      (cons x set)))
