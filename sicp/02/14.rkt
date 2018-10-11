#lang racket
;; ex 02.14
;; interval arithmetic inestigate Lem's bug report
;;
;; Demonstrate that Lem is right. Investigate the behavior of the
;; system on a variety of arithmetic expressions. Make some
;; intervals A and B, and use them in computing the expressions
;; A/A and A/B. You will get the most insight by using intervals
;; whose width is a small percentage of the center value. Examine
;; the results of the computation in center-percent form (see
;; exercise 2.12).

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))

(define a (make-center-percent 4.0 5.0))
(define b (make-center-percent 2.0 1.0))

(define a-over-a (div-interval a a))
(define a-over-b (div-interval a b))

(center a-over-a)
(center a-over-b)
(percent a-over-a)
(percent a-over-b)

;; some big difference here
(par1 a b)
(par2 a b)
(par1 a a)
(par2 a a)

;;;;
;; code from prev exercieses
;;;;
(define (make-center-percent c t)
  (make-center-width c (/ (* c t) 100)))

(define (percent i)
  (/ (* (width i) 100) (center i)))

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

(define (add-interval a b)
  (make-interval (+ (lower-bound a) (lower-bound b))
                 (+ (upper-bound a) (upper-bound b))))

(define (sub-interval a b)
  (make-interval (- (lower-bound a) (lower-bound b))
                 (- (upper-bound a) (upper-bound b))))

(define (mul-interval a b)
  (let ((p1 (* (lower-bound a) (lower-bound b)))
        (p2 (* (lower-bound a) (upper-bound b)))
        (p3 (* (upper-bound a) (lower-bound b)))
        (p4 (* (upper-bound a) (upper-bound b))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval a b)
  (mul-interval a
                (make-interval (/ 1.0 (upper-bound b))
                               (/ 1.0 (lower-bound b)))))
