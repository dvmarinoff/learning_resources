#lang racket
;; ex 02.02
;; representing line segments in a plane
;;
;; Consider the problem of representing line segments in a plane.
;; Each segment is represented as a pair of points: a starting
;; point and an ending point. Define a constructor make-segment
;; and selectors start-segment and end-segment that define the
;; representation of segments in terms of points. Furthermore, a
;; point can be represented as a pair of numbers: the x
;; coordinate and the y coordinate. Accordingly, specify a
;; constructor make-point and selectors x-point and y-point that
;; define this representation. Finally, using your selectors and
;; constructors, define a procedure midpoint-segment that takes a
;; line segment as argument and returns its midpoint (the point
;; whose coordinates are the average of the coordinates of the
;; endpoints). To try your procedures, you'll need a way to print
;; points:
;;
;; (define (print-point p)
;;   (newline)
;;   (display "(")
;;   (display (x-point p))
;;   (display ",")
;;   (display (y-point p))
;;   (display ")"))

(define (p point)
  (newline)
  (display (format "(~a,~a)"
                   (x-point point)
                   (y-point point))))

(define (make-segment p-start p-end)
  (cons p-start p-end))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

(define (make-point x y)
  (cons x y))

(define (x-point point)
  (car point))

(define (y-point point)
  (cdr point))

(define (midpoint-segment segment)
  (make-point (average (x-point (start-segment segment))
                       (x-point (end-segment segment)))
              (average (y-point (start-segment segment))
                       (y-point (end-segment segment)))))

(define (average a b)
  (/ (+ a b) 2.0))

(define origin (make-point 0 0))
(define p1 (make-point 1.0 1.0))
(define p2 (make-point 3.0 3.0))
(define p1-p2 (make-segment p1 p2))
(define mid-point-p1-p2 (midpoint-segment p1-p2))

(p p1)
(p p2)
(p p1-p2)
(p mid-point-p1-p2)
