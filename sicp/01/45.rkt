#lang racket
;; ex 01.45
;; compute n-th roots with average-damp procedure
;;
;; We saw in section 1.3.3 that attempting to compute square
;; roots by naively finding a fixed x/y does not converge, and
;; that this can be fixed by average damping. The same method
;; point of y works for finding cube roots as fixed points of the
;; average-damped y x/y^{2} . Unfortunately, the process does not
;; work for fourth roots -- a single average damp is not enough
;; to make a fixed-point search for y x/y{3}  converge. On the
;; other hand, if we average damp twice (i.e., use the average
;; damp of the average damp of y x/y{3}  ) the fixed-point search
;; does converge. Do some experiments to determine how many
;; average damps are required to compute nth roots as a
;; fixed-point search based upon repeated average damping of
;; y -> x/y^{n-1}. Use this to implement a simple procedure for
;; computing nth roots using fixed- point, average-damp, and the
;; repeated procedure of exercise 1.43. Assume that any
;; arithmetic operations you need are available as primitives

;; (nth-root 2 4)
;; (nth-root 3 8)
;; (nth-root 4 16)
;; (nth-root 5 32)
;; (nth-root 6 64)
;; (nth-root 7 128)
;; (nth-root 8 256)
;; (nth-root 9 512)
;; (nth-root 10 1024)
;; (nth-root 16 65536)
;; (nth-root 17 131072)
;; (nth-root 32 4294967296)
;;
;; (expt 2 17)
;;
;; - it is about log_{2}(n)
;; - floor and round give better results than ceiling

(define (nth-root n x)
  (fixed-point ((repeated average-damp (round (log-2 n)))
                (lambda (y) (/ x (expt y (dec n)))))
               1.0))

(define (log-base n x)
  (/ (log x) (log n)))

(define (log-2 x)
  (log-base 2 x))

(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define tolerance 0.000001)

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (average a b)
  (/ (+ a b) 2))

(define (repeated f n)
  (lambda (x)
    (recur f n x)))

(define (recur f n x)
  (if (= 0 n)
      x
      (f (recur f (dec n) x))))

(define (dec x)
  (- x 1))
