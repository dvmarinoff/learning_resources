#lang racket
;; ex 02.46
;; picture language 2d vectors
;;
;; A two-dimensional vector v running from the origin to a point
;; can be represented as a pair consisting of an x-coordinate and
;; a y-coordinate. Implement a data abstraction for vectors by
;; giving a constructor make-vect and corresponding selectors
;; xcor-vect and ycor-vect. In terms of your selectors and
;; constructor, implement procedures add-vect, sub-vect, and
;; scale-vect that perform the operations vector addition, vector
;; subtraction, and multiplying a vector by a scalar:
;;
;;(x_{1}, y_{1}) + (x_{2}, y_{2}) = (x_{1} + x_{2}, y_{1} + y_{1})
;;(x_{1}, y_{1}) - (x_{2}, y_{2}) = (x_{1} - x_{2}, y_{1} - y_{1})
;;s * (x, y) = (sx, sy)

(define (make-vect x y)
  (cons x y))

(define (xcor-vect vect)
  (car vect))

(define (ycor-vect vect)
  (cdr vect))

(define (add-vect v1 v2)
  (make-vect (+ (xcor-vect v1)
                (xcor-vect v2))
             (+ (ycor-vect v1)
                (ycor-vect v2))))

(define (sub-vect v1 v2)
  (make-vect (- (xcor-vect v1)
                (xcor-vect v2))
             (- (ycor-vect v1)
                (ycor-vect v2))))

(define (scale-vect scalar vect)
  (make-vect (* scalar (xcor-vect vect))
             (* scalar (xcor-vect vect))))
