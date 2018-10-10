#lang racket
;; ex 02.09
;; interval arithmetic width of an interval
;;The width of an interval is half of the difference between
;; its upper and lower bounds. The width is a measure of the
;; uncertainty of the number specified by the interval. For some
;; arithmetic operations the width of the result of combining two
;; intervals is a function only of the widths of the argument
;; intervals, whereas for others the width of the combination is
;; not a function of the widths of the argument intervals. Show
;; that the width of the sum (or difference) of two intervals is
;; a function only of the widths of the intervals being added (or
;; subtracted). Give examples to show that this is not true for
;; multiplication or division.

;; well this is gonna be too much ascii or 'latex' so here
;; is some code:

(define i1 (make-interval 1 3))
(define i2 (make-interval 3 5))

(define w1 (width-interval i1))
(define w2 (width-interval i2))

(equal? (width-interval (add-interval i1 i2))
        (+ (width-interval i1)
           (width-interval i2)))
;; -> #t

(equal? (width-interval (sub-interval i1 i2))
        (- (width-interval i1)
           (width-interval i2)))
;; -> #t

(equal? (width-interval (mul-interval i1 i2))
        (* (width-interval i1)
           (width-interval i2)))
;; -> #f

(equal? (width-interval (div-interval i1 i2))
        (/ (width-interval i1)
           (width-interval i2)))
;; -> #f

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

(define (width-interval interval)
  (/ (- (upper-bound interval) (lower-bound interval)) 2))
