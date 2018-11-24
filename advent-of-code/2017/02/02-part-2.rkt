#lang racket
;; Advent of Code - 2017
;; 02. Corruption Checksum

;;;;
;; Part 2
;;;;

;; 5 9 2 8 -> 8 / 2
;; 9 4 7 3 -> 9 / 3
;; 3 8 6 5 -> 6 / 3

;; 4 + 3 + 2 = 9
(define test-matrix '((5 9 2 8) (9 4 7 3) (3 8 6 5)))

(define (check-sum acc xs)
  (cond ((not (pair? xs)) acc)
        (else (check-sum
               (+ acc
                  (quotient (find-divisible-pair (car xs))))
               (cdr xs)))))

;; TODO: optimize the algorithm while maintaining the fp spirit
;; the second cond case does the search twice, it needs to be
;; remembered somewhere
(define (find-divisible-pair xs)
  (define (recur dividend-divisor xs)
    (cond ((not (pair? xs)) dividend-divisor)
          ((not (null? (search xs)))
          (recur (make-division-pair (car xs)
                                     (car (search xs)))
                 (cdr xs)))
         (else (recur dividend-divisor (cdr xs)))))
  (recur null xs))

(define (search xs)
  (filter (curry even-division? (car xs)) (cdr xs)))

(define (even-division? x y)
  (if (or (zero? x) (zero? y))
      #f
      (or (integer? (/ x y)) (integer? (/ y x)))))

(define (make-division-pair x y)
  (cond ((integer? (/ x y)) (cons x y))
        ((integer? (/ y x)) (cons y x))
        (else (cons null null))))
(define (dividend p) (car p))
(define (divisor p) (cdr p))
(define (quotient p)
  (/ (dividend p) (divisor p)))

;; (check-sum 0 int-matrix)
;; (check-sum 0 input)

(define fl (file->lines "./input-part-2.txt" 	#:line-mode 'linefeed))

(define int-matrix (map (lambda (line)
                          (map string->number
                               (string-split line #rx"\t"))) fl))
