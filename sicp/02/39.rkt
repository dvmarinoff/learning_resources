#lang racket
;; ex 02.39
;; reverse in terms of fold
;; Complete the following definitions of reverse (exercise 2.18)
;; in terms of fold-right and fold-left from exercise 2.38:
;;
;; (define (reverse sequence)
;;   (fold-right (lambda (x y) <??>) nil sequence))
;;
;; (define (reverse sequence)
;;   (fold-left (lambda (x y) <??>) nil sequence))

(define (reverse-r sequence)
  (fold-right (lambda (x y) (append y (list x))) null sequence))

(define (reverse-l sequence)
  (fold-left (lambda (x y) (cons y x)) null sequence))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(define (fold-right op initial sequence)
  (accumulate op initial sequence))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))
