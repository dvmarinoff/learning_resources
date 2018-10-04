#lang racket
;; ex 01.38
;; approximate e based on Euler's expansion
;;
;; In 1737, the Swiss mathematician Leonhard Euler published a
;; memoir De Fractionibus Continuis, which included a continued
;; fraction expansion for e - 2, where e is the base of the
;; natural logarithms. In this fraction, the N i are all 1, and
;; the D i are successively 1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8, ....
;; Write a program that uses your cont-frac procedure from
;; exercise 1.37 to approximate e, based on Euler's expansion.

(define (approximate-eulers-number precision)
  (+ 2 (co>nt-frac-iter (lambda (i) 1.0) series-term precision)))

(define eulers-number 2.7182818284523)

(define (series-term i)
  (if (= (modulo (inc i) 3) 0)
      (* 2 (/ (inc i) 3))
      1))

(define (cont-frac-iter n d k)
  (define (iter k next)
    (if (= 0 k)
        next
        (iter (dec k) (/ (n k)
                         (+ (d k) next)))))
  (iter k 0))

(define (dec x)
  (- x 1))

(define (inc x)
  (+ x 1))

;; 1 2 1 1 4 1 1 6 1  1  8 ...
;;
;; 1 2 3 4 5 6 7 8 9 10 11
;;
;;   1     2     3      4
;;
;; a_1 = 1
;; a_2 = 2 = 2 * 1
;; a_3 = 1 = 1 * 1
;; a_4 = 1 = 1 * 1
;; a_5 = 4 = 2 * 2
;; a_8 = 6 = 2 * 3
;; a_11 = 8 = 2 * 4
;; ...
;; a_i = ((a_i + 1) / 3) * 2, where (i + 1) % 3 = 0
;; a_i = 1
