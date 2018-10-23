#lang racket
;; ex 02.40
;; unique paird procedure
;;
;; Define a procedure unique-pairs that, given an integer n,
;; generates the sequence of pairs (i,j) with 1< j< i< n. Use
;; unique-pairs to simplify the definition of prime-sum-pairs
;; given above.

(require math/number-theory)

(define (unique-pairs n) n)

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (flatmap
                (lambda (i)
                  (map (lambda (j) (list i j))
                       (enumerate-interval 1 (- i 1))))
                (enumerate-interval 1 n)))))

(prime-sum-pairs 2)

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (flatmap proc seq)
  (accumulate append null (map proc seq)))

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (enumerate-interval low high)
  (if (> low high)
      null
      (cons low (enumerate-interval (+ low 1) high))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))
