#lang racket
;; ex 02.12
;; interval arithmetic make-center-percent constructor
;;
;; Define a constructor make-center-percent that takes a center
;; and a percentage tolerance and produces the desired interval.
;; You must also define a selector percent that produces the
;; percentage tolerance for a given interval. The center selector
;; is the same as the one shown above.

;; (/ (- (+ 3.5 0.15) (- 3.5 0.15)) 2)
;; (/ (* 0.15 100) 3.5)
;; (/ (* 3.5 4.28) 100)

;;;;
;; solution
;;;;

(define (make-center-percent c t)
  (make-center-width c (/ (* c t) 100)))

(define (percent i)
  (/ (* (width i) 100) (center i)))

;;;;
;; code from prev exercieses
;;;;
(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (make-interval a b)
  (cons a b))

(define (lower-bound interval)
  (car interval))

(define (upper-bound interval)
  (cdr interval))
