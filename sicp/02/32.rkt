#lang racket
;; ex 02.32
;; the power set
;;
;; We can represent a set as a list of distinct elements, and we
;; can represent the set of all subsets of the set as a list of
;; lists. For example, if the set is (1 2 3), then the set of all
;; subsets is (() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3)).
;; Complete the following definition of a procedure that
;; generates the set of subsets of a set and give a clear
;; explanation of why it works:
;;
;; (define (subsets s)
;;   (if (null? s)
;;       (list nil)
;;       (let ((rest (subsets (cdr s))))
;;         (append rest (map <??> rest)))))

(define (subsets s)
  (if (null? s)
      (list null)
      (let ((rest (subsets (cdr s))))
        (append rest (map (curry union s) rest)))))

;; Given a set S, the power set of S is the set of all subsets of
;; the set S including the empty set and the set S itself.
;; The power set of S is denoted by P(S). - Rosen
;;
;; F(e, T) = {X \union {e} | X \in T}

(define (union e x)
  (cons (car e) x))
