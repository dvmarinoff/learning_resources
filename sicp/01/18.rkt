;; ex 1.18
;; Using the results of exercises 1.16 and 1.17, devise a
;; procedure that generates an iterative process for multiplying
;; two integers in terms of adding, doubling, and halving and
;; uses a logarithmic number of steps.

(define (double x)
  (+ x x))

(define (halve x)
  (/ x 2))

(define (mul x y)
  (mul-iter x y 0))

(define (mul-iter x y a)
  (cond ((= y 0) a)
        ((even? y) (mul-iter (double x) (halve y) a))
        (else (mul-iter x (- y 1) (+ a x)))))
