#lang racket
;; ex 02.17
;; last-pair procedure
;;
;; Define a procedure last-pair that returns the list that
;; contains only the last element of a given (nonempty) list:
;;
;; (last-pair (list 23 72 149 34))
;; (34)

(last-pair (list 23 72 149 34))
(last-pair (list 23))
(last-pair '())

(define (last-pair lst)
  (display (format "~a\n" lst))
  (cond ((empty? lst) '())
        ((null? (cdr lst)) lst)
        (else (last-pair (cdr lst)))))
