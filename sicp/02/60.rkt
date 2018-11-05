#lang racket
;; ex 02.60
;; sets as unordered-lists with duplication
;;
;; We specified that a set would be represented as a list with no
;; duplicates. Now suppose we allow duplicates. For instance,
;; the set {1, 2, 3} could be represented as the list
;; (2 3 2 1 3 2 2) . Design procedures element-of-set?,
;; adjoin-set , union-set , and intersection-set that operate on
;; this representation. How does the efficiency of each compare
;; with the corresponding procedure for the non-duplicate
;; representation? Are there applications for which you would use
;; this representation in preference to the non-duplicate one?

;; Well, I'll just stop checking with member-of-set? procedure,
;; in adjoin-set. This is 1 loop over n for each check, now gone.
;; The offside is maybe that having duplicates will bring the size
;; of the set up, which might be more work for union-set and
;; intersection-set. I guess having that many duplicates so that
;; it has some really negative effect on the performance on the
;; later 2 operations is going to be rare, but in this case I'll
;; prefer the penalty for removing them.
(define (adjoin-set x set)
  (cons x set))

(define (union-set set1 set2)
  (foldr (lambda (x acc) (adjoin-set x acc)) set2 set1))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (adjoin-set (car set1) (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

;;;;
;; Required code
;;;;
(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((equal? (car set) x) #t)
        (else (element-of-set? x (cdr set)))))
