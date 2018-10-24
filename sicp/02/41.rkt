#lang racket
;; ex 02.41
;; find ordered triples <= n that sum to s
;;
;; Write a procedure to find all ordered triples of distinct
;; positive integers i, j, and k less than or equal to a given
;; integer n that sum to a given integer s.

;;;;
;; solution
;;;;
(define (ordered-triples-sum n s)
  (filter (curry sum-to? s) (unique-triples n)))

(define (unique-triples n)
  (flatmap (lambda (i)
             (flatmap (lambda(j)
                    (map (lambda (k)
                           (list i j k))
                         (enumerate-interval 1 (- j 1))))
                  (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 n)))

(define (sum-to? s xs)
  (equal? s (sum xs)))

(define (sum xs)
  (foldl + 0 xs))

;;;;
;; required code
;;;;
(define (flatmap proc seq)
  (accumulate append null (map proc seq)))

(define (enumerate-interval low high)
  (if (> low high)
      null
      (cons low (enumerate-interval (+ low 1) high))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))
