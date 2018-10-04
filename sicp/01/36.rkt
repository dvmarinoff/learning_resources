#lang racket
;; ex 01.36
;; explore the fixed-point procedure

;; Modify fixed-point so that it prints the sequence of
;; approximations it generates, using the newline and display
;; primitives shown in exercise 1.22. Then find a solution to
;; x^{x} = 1000 by finding a fixed point log(1000)/log(x).
;; (Use Scheme's primitive log procedure, which computes  of x
;; natural logarithms.) Compare the number of steps this takes
;; with and without average damping. (Note that you cannot start
;; fixed-point with a guess of 1, as this would cause division by
;; log(1) = 0.)


(fixed-point-iter h 2.0)

(fixed-point-iter (average-damp h) 2.0)

(fixed-point-average-damp-iter h 2.0)

;;| starting value | iterations | average-damp | average-damp as arg |
;;|----------------+------------+--------------+---------------------|
;;|            1.1 |         37 |            9 |                  13 |
;;|            2.0 |         34 |            8 |                   9 |
;;|            3.0 |         32 |            8 |                   8 |
;;|            4.0 |         29 |            7 |                   7 |
;;|            4.5 |         23 |            6 |                   6 |
;;|           4.55 |         18 |            5 |                   5 |
;;|          4.555 |         12 |            4 |                   4 |
;;|         4.5555 |          6 |            2 |                   2 |

(define (h x)
  (/ (log 1000) (log x)))

(define (average-damp f)
  (lambda (x)
    (average (f x) x)))

(define (average a b)
  (/ (+ a b) 2))

(define (fixed-point-iter f first-guess)
  (define (try guess i)
    (let ((next (f guess))
          (iterations (inc i)))
      (report iterations guess)
      (if (close-enough? guess next)
          next
          (try next iterations))))
  (try first-guess 0))

(define (fixed-point-average-damp-iter f first-guess)
  (define (try guess i)
    (let ((next (f guess))
          (iterations (inc i)))
      (report iterations guess)
      (if (close-enough? guess next)
          next
          (try ((average-damp f) next) iterations))))
    (try first-guess 0))

(define (close-enough? x y)
  (< (abs (- x y)) tolerance))

(define tolerance 0.00001)

(define (report iterations guess)
  (display (format "~a - ~a" iterations guess))
  (newline))

(define (inc x)
  (+ x 1))
