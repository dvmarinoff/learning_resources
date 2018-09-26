#lang racket
;; ex 01.31
;; higher-order product procedure

;; a.
;; The sum procedure is only the simplest of a vast number of
;; similar abstractions that can be captured as higher-order
;; procedures. 51 Write an analogous procedure called product that
;; returns the product of the values of a function at points over
;; a given range. Show how to define factorial in terms of product
;; Also use product to compute approximations to using the formula

;;$$\frac{\pi}{4} = \frac{2\cdot4\cdot4\cdot6\cdot6\cdot8}{3\cdot3\cdot5\cdot5\cdot7\cdot7}$$

;; b.
;; If your product procedure generates a recursive process, write
;; one that generates an iterative process. If it generates an
;; iterative process, write one that generates a recursive process

;; a.
(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (identity x) x)

(define (inc x)
  (+ x 1))

(define (factorial n)
  (product identity 1 inc n))

(define (pi-aprox precision)
  (* 4 (product pi-term 1.0 inc precision)))

(define (pi-term x)
  (/ (* 2 (quotient (+ x 2) 2))
     (+ 1 (* 2 (quotient (+ x 1) 2)))))

;; b.
(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* (term a) result))))
  (iter a 1))

(define (factorial-iter n)
  (product-iter identity 1 inc n))

(define (pi-aprox-iter precision)
  (* 4 (product pi-term 1.0 inc precision)))
