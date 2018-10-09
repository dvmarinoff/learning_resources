#lang racket
;; ex 02.03
;; representing rectangles in a plane
;;
;; Implement a representation for rectangles in a plane. (Hint:
;; You may want to make use of exercise 2.2.) In terms of your
;; constructors and selectors, create procedures that compute the
;; perimeter and the area of a given rectangle. Now implement a
;; different representation for rectangles. Can you design your
;; system with suitable abstraction barriers, so that the same
;; perimeter and area procedures will work using either
;; representation?

;;;;
;; rectangle api
;;;;
(define (perimeter rect)
  (let ((a (segment-length (side-left rect)))
        (b (segment-length (side-bottom rect))))
    (+ (+ a a) (+ b b))))

(define (area rect)
  (* (segment-length (side-left rect))
     (segment-length (side-bottom rect))))

(define (print-rect rect)
  (display (format "left: ~a\nbottom: ~a\ntop: ~a\nright: ~a"
                   (side-left rect)
                   (side-bottom rect)
                   (side-top rect)
                   (side-right rect))))

;;;;
;; representation 1 - construct with 4 segments
;;;;
(define (make-rect side-left side-bottom side-top side-right)
  (list side-left side-bottom side-top side-right))

(define (make-rect-side x1 y1 x2 y2)
  (make-segment (make-point x1 y1)
                (make-point x2 y2)))

(define (side-left rect)
  (car rect))

(define (side-bottom rect)
  (cadr rect))

(define (side-top rect)
  (caddr rect))

(define (side-right rect)
  (cadddr rect))

;; public usage of rep. 1
(define A (make-rect-side 0 0 0 4))
(define B (make-rect-side 0 0 4 0))
(define C (make-rect-side 4 0 4 4))
(define D (make-rect-side 0 4 4 4))

(define ABCD (make-rect A B C D))

(print-rect ABCD)

(area ABCD)

;;;;
;; representation 2 - construct from 2 diagonal points
;;
;; y
;; ^
;; |  (x1,y2)     (x2,y2)
;; +  +-----------+
;; |  |           |
;; +  +-----------+
;; |  (x1,y1)     (x2,y1)
;; +--+--+--+--+--+--+--+--> x
;;
;;;;

(define (make-rect bottom-left-point top-right-point)
  (let ((bottom-right-point (make-point (car top-right-point)
                                        (cdr bottom-left-point)))
        (top-left-point (make-point (car bottom-left-point)
                                    (cdr top-right-point))))
    (list bottom-left-point
          top-right-point
          bottom-right-point
          top-left-point)))

(define (side-left rect)
  (make-segment (car rect) (cadddr rect)))

(define (side-bottom rect)
  (make-segment (car rect) (caddr rect)))

(define (side-top rect)
  (make-segment (cadddr rect) (cadr rect)))

(define (side-right rect)
  (make-segment (caddr rect) (cadr rect)))

;; public usage of rep. 2
(define abcd (make-rect (make-point 0 0)
                        (make-point 4 4)))

(print-rect abcd)

(area abcd)

;;;;
;; expanding segment api form ex 2.2
;;;;
(define (segment-length segment)
  (sqrt (+ (sqr (abs (- (x-point (start-segment segment))
                        (x-point (end-segment segment)))))
           (sqr (abs (- (y-point (start-segment segment))
                        (y-point (end-segment segment))))))))

;;;;
;; point and segment from ex. 2.2
;;;;
(define (make-segment p-start p-end)
  (list p-start p-end))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cadr segment))

(define (make-point x y)
  (cons x y))

(define (x-point point)
  (car point))

(define (y-point point)
  (cdr point))
