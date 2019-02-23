#lang racket
;; Advent of Code - 2017
;; 03. Spiral memory

;;;;
;; Part 2
;;;;

;; The Ulam spiral
;;
;; 65 64 63 62 61 60 59 58 57
;; 66 37 36 35 34 33 32 31 56
;; 67 38 17 16 15 14 13 30 55
;; 68 39 18  5  4  3 12 29 54
;; 69 40 19  6  1  2 11 28 53
;; 70 41 20  7  8  9 10 27 52
;; 71 42 21 22 23 24 25 26 51
;; 72 43 44 45 46 47 48 49 50
;; 73 74 75 76 77 78 79 80 81
;;                           121
;;                              169
;;                                 225
;;

;; The Existing Neigbour Sum spiral
;;
;; 147  142  133  122   59
;; 304    5    4    2   57
;; 330   10    1    1   54
;; 351   11   23   25   26
;; 362  747  806
;;
;;
;; 147  142  133  122   59
;; 304    5    4    2   57
;; 330   10    1    1   54
;; 351   11   23   25   26
;; 362  747  806  854  905
;;
;; n_i = n_i-1  + Existing Neighbors
;;
;; 1 5 7 9

;;

(define (spiral s n)
  (cond ((= n 1) s)
        (else (spiral (s) (dec n)))))

(define (inc x) (+ x 1))
(define (dec x) (- x 1))

(define (make-spiral n)
  (define (recur n)
    (cond (())))
  (recur n))

(define (make-cell coord-pair index value)
  (list coord-pair index value))
(define (cell-coords cell) (car cell))
(define (cell-index cell) (cadr cell))
(define (cell-value cell) (caddr cell))

(define (make-point x y) (cons x y))
(define (x-coord point) (car point))
(define (y-coord point) (cdr point))


(cell-coords (make-cell (make-point 1 1) 3 2))
(cell-index (make-cell (make-point 1 1) 3 2))
(cell-value (make-cell (make-point 1 1) 3 2))
