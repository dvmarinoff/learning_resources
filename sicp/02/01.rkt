#lang racket
;; ex 02.01
;; better make-rat
;;
;; Define a better version of make-rat that handles both positive
;; and negative arguments. Make-rat should normalize the sign so
;; that if the rational number is positive, both the numerator
;; and denominator are positive, and if the rational number is
;; negative, only the numerator is negative.

;; regular make-rat:
;; (define (make-rat n d)
;;   (let ((g (gcd n d)))
;;     (cons (/ n g) (/ d g))))

(define (make-rat n d)
  (let ((g (abs (gcd n d))))
    (if (negative? d)
        (cons (/ (- 0 n) g) (/ (abs d) g))
        (cons (/ n g) (/ d g)))))

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (p x)
  (display (format "~a/~a" (car x) (cdr x))))

(p (make-rat 3 -6))
(p (make-rat -3 -6))
(p (make-rat -3 6))
