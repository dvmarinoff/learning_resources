#lang racket
;; ex 01.35
;; phi by fixed-point procedure
;;
;; Show that the golden ratio (section 1.2.2) is a fixed point of
;; the transformation x -> 1 + 1/x, and use this fact to compute
;; \phi by means of the fixed-point procedure

(define (main n) n)

(fixed-point cos 1.0)

(fixed-point cont-fraction-phi 1.0)

(define (cont-fraction-phi x)
  (+ 1 (/ 1 x)))

(define (fixed-point f guess)
  (define next (f guess))
  (if (close-enough? guess next)
      next
      (fixed-point f next)))

(define (fixed-point-iter f first-guess)
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (close-enough? x y)
  (< (abs (- x y)) tolerance))

(define tolerance 0.00001)
