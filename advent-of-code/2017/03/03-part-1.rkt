#lang racket
;; Advent of Code - 2017
;; 03. Spiral memory

;;;;
;; Part 1
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
;; We can make the observation about the following mapping:
;;
;; (0,0) value - 1 9 25 49 81 121 169 225
;; side size   - 1 3  5  7  9  11  13  15
;;
;; Square side = S
;; Origin value = O_{v}
;;
;; S^{2} = O_{v}
;;
;; As is we are only interested in one single line segment, the one
;; that goes around the square and finishes at S^{2}, from which
;; we can calculate the distance.
;;
;; Example
;; side 5 -> origin is 25, the line starts at (side - 2)^{2} + 1
;; which is 10 in this case.
;;
;;| 25 | 24 23 22 | 21 | 20 19 18 | 17 | 16 15 14 | 13 | 12 11 10
;;|  4 |  3  2  3 |  4 |  3  2  3 |  4 |  3  2  3 |  4 |  3  2  3
;;           -               -               -               -
;;
;; max distance is 4: side - 1
;; min distance is 2: side / 2
;;
;; We just generate the segment and take the corresponding distance.
;;
;; TODO: find some clever way to make the mapping of distance to
;; value in segment, like formula or something

(define (search-distance n)
  (define side (search-side-size n))
  (define line (line-values side))
  (define max-distance (dec side))
  (define min-distance (/ max-distance 2))
  (define (search n distance update line)
    (cond ((null? line) null)
          ((= (car line) n) distance)
          ((= distance max-distance)
           (search n (dec distance) dec (cdr line)))
          ((= distance min-distance)
           (search n (inc distance) inc (cdr line)))
          (else (search n (update distance) update (cdr line)))))
  (search n (dec max-distance) dec line))

;; (search-distance 361527)

(define (search-side-size n)
  (define (recur side n)
    (cond ((<= n (sqr side)) side)
          (else (recur (+ side 2) n))))
  (recur 1 n))

(define (line-values side)
  (range  (inc (sqr (- side 2))) (inc (sqr side))))

(define (inc x) (+ x 1))
(define (dec x) (- x 1))
