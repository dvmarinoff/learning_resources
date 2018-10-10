#lang racket
;; ex 02.11
;; interval arithmetic reduce operations in mul-interval
;;
;; In passing, Ben also cryptically comments: ``By testing the
;; signs of the endpoints of the intervals, it is possible to
;; break mul-interval into nine cases, only one of which requires
;; more than two multiplications.'' Rewrite this procedure using
;; Ben's suggestion. After debugging her program, Alyssa shows it
;; to a potential user, who complains that her program solves the
;; wrong problem. He wants a program that can deal with numbers
;; represented as a center value and an additive tolerance; for
;; example, he wants to work with intervals such as 3.5± 0.15
;; rather than [3.35, 3.65]. Alyssa returns to her desk and fixes
;; this problem by supplying an alternate constructor and
;; alternate selectors:

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

;; Unfortunately, most of Alyssa's users are engineers. Real
;; engineering situations usually involve measurements with only
;; a small uncertainty, measured as the ratio of the width of the
;; interval to the midpoint of the interval. Engineers usually
;; specify percentage tolerances on the parameters of devices, as
;; in the resistor specifications given earlier.

(define (mul-interval a b)
  (let ((p1 (* (lower-bound a) (lower-bound b)))
        (p2 (* (lower-bound a) (upper-bound b)))
        (p3 (* (upper-bound a) (lower-bound b)))
        (p4 (* (upper-bound a) (upper-bound b))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

;; (+, +) * (+, +) | (* lower-a lower-b) (* upper-a upper-b)
;; (+, +) * (-, +) | (* upper-a lower-b) (* upper-a upper-b)
;; (+, +) * (-, -) | (* upper-a lower-b) (* lower-a upper-b)
;;
;; (-, +) * (+, +) | (* lower-a upper-b) (* upper-a upper-b)
;; (-, +) * (-, +) | (min (* lower-a lower-b) (* lower-a upper-b))
;;                 | (max (* lower-a lower-b) (* upper-a upper-b))
;; (-, +) * (-, -) | (* upper-a lower-b) (* lower-a lower-b)
;;
;; (-, -) * (+, +) | (* lower-a upper-b) (* upper-a lower-b)
;; (-, -) * (-, +) | (* lower-a upper-b) (* lower-a lower-b)
;; (-, -) * (-, -) | (* upper-a upper-b) (* lower-a lower-b)

(define (mul-iterval a b)
  (let ((lower-a (lower-bound a))
        (upper-a (upper-bound a))
        (lower-b (lower-bound b))
        (upper-b (upper-bound b)))
    (cond ((and (positive? lower-a)
                (positive? upper-a)
                (positive? lower-b)
                (positive? upper-b))
           (make-interval (* lower-a lower-b)
                          (* upper-a upper-b)))
          ((and (positive? lower-a)
                (positive? upper-a)
                (negative? lower-b)
                (positive? upper-b))
           (make-interval (* upper-a lower-b)
                          (* upper-a upper-b)))
          ((and (positive? lower-a)
                (positive? upper-a)
                (negative? lower-b)
                (negative? upper-b))
           (make-interval (* upper-a lower-b)
                          (* lower-a upper-b)))
          ((and (negative? lower-a)
                (positive? upper-a)
                (positive? lower-b)
                (positive? upper-b))
           (make-interval (* lower-a upper-b)
                          (* upper-a upper-b)))
          ((and (negative? lower-a)
                (positive? upper-a)
                (negative? lower-b)
                (positive? upper-b))
           (make-interval (min (* lower-a lower-b)
                               (* lower-a upper-b))
                          (max (* lower-a lower-b)
                               (* upper-a upper-b))))
          ((and (negative? lower-a)
                (positive? upper-a)
                (negative? lower-b)
                (negative? upper-b))
           (make-interval (* upper-a lower-b)
                          (* lower-a lower-b)))
          ((and (negative? lower-a)
                (negative? upper-a)
                (positive? lower-b)
                (positive? upper-b))
           (make-interval (* lower-a upper-b)
                          (* upper-a lower-b)))
          ((and (negative? lower-a)
                (negative? upper-a)
                (negative? lower-b)
                (positive? upper-b))
           (make-interval (* lower-a upper-b)
                          (* lower-a lower-b)))
          ((and (negative? lower-a)
                (negative? upper-a)
                (negative? lower-b)
                (negative? upper-b))
           (make-interval (* upper-a upper-b)
                          (* lower-a lower-b))))))

(define (make-interval a b)
  (cons a b))

(define (lower-bound interval)
  (car interval))

(define (upper-bound interval)
  (cdr interval))

(define (width-interval interval)
  (/ (- (upper-bound interval) (lower-bound interval)) 2))
