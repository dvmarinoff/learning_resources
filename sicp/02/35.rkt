#lang racket
;; ex 02.35
;; count-leaves as accumulation
;;
;; Redefine count-leaves from section 2.2.2 as an accumulation:
;; (define (count-leaves t)
;;   (accumulate <??> <??> (map <??> <??>)))

(define (count-leaves t)
  (accumulate + 0 (map (lambda (x)
                         (if (pair? x)
                             (count-leaves x)
                             1)) t)))

;; Accumulate + over 0 with the recursive map over the sub-trees.
;; Instead of car and cdr you descent with a recursive call to
;; the main function
;;
;; (define (count-leaves-old x)
;;   (cond ((null? x) 0)
;;         ((not (pair? x)) 1)
;;         (else (+ (count-leaves (car x))
;;                  (count-leaves (cdr x))))))
