;; ex 1.8
;; Newton's method for cube roots is based on the fact that if y
;; is an approximation to the cube root of x, then a better
;; approximation is given by the value

;; (x/y^2 + 2y) / 3

;; Use this formula to implement a cube-root procedure analogous
;; to the square-root procedure.

(define (cube-root guess x)
  (if (good-enuf? guess x)
      guess
      (cube-root (improve guess x) x)))

(define (good-enuf? guess x)
  (< (abs (- (* guess guess guess) x)) tolerance))

(define tolerance 0.0001)

(define (improve y x)
  (/ (+ (/ x (* y y)) (* 2 y)) 3))

(good-enuf? 3 27)
;; (cube-root (/ 27 2) 27)
