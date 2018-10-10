#lang racket
;; ex 02.10
;; interval arithmetic zero division
;;
;; Ben Bitdiddle, an expert systems programmer, looks over
;; Alyssa's shoulder and comments that it is not clear what it
;; means to divide by an interval that spans zero. Modify
;; Alyssa's code to check for this condition and to signal an
;; error if it occurs.

(div-interval (make-interval 1.1 1.4)
              (make-interval 0 1))

(div-interval (make-interval 1.1 1.4)
              (make-interval 1 0))

(define (div-interval a b)
  (cond ((zero? (or (upper-bound b) (lower-bound b)))
         (error "div by zero interval" 0))
        (else (mul-interval a
                       (make-interval (/ 1.0 (upper-bound b))
                                      (/ 1.0 (lower-bound b)))))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (make-interval a b)
  (cons a b))

(define (upper-bound interval)
  (cdr interval))

(define (lower-bound interval)
  (car interval))
