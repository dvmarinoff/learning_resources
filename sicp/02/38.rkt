#lang racket
;; ex 02.38
;; explore fold-left and fold-right
;;
;; The accumulate procedure is also known as fold-right, because
;; it combines the first element of the sequence with the result
;; of combining all the elements to the right. There is also a
;; fold- left, which is similar to fold-right, except that it
;; combines elements working in the opposite direction:
;;
;; (define (fold-left op initial sequence)
;;             (define (iter result rest)
;;               (if (null? rest)
;;                   result
;;                   (iter (op result (car rest))
;;                         (cdr rest))))
;;             (iter initial sequence))
;;
;; What are the values of
;;
;; (fold-right / 1 (list 1 2 3))
;;
;; (fold-left / 1 (list 1 2 3))
;;
;; (fold-right list nil (list 1 2 3))
;;
;; (fold-left list nil (list 1 2 3))
;;
;; Give a property that op should satisfy to guarantee that
;; fold-right and fold-left will produce the same values for any
;; sequence.

(define (fold-left op initial sequence)
            (define (iter result rest)
              (if (null? rest)
                  result
                  (iter (op result (car rest))
                        (cdr rest))))
            (iter initial sequence))

(define (fold-right op initial sequence)
  (accumulate op initial sequence))

(fold-right / 1 (list 1 2 3))
;; => 3/2

(fold-left / 1 (list 1 2 3))
;; => 1/6

(fold-right list null (list 1 2 3))
;; => (1 (2 (3 ())))

(fold-left list null (list 1 2 3))
;; => (((() 1) 2) 3)

;; the operation should be associative, meaning agnostic to order
;; of application like + or * on integers
;; (1 + 2 + 3) = (3 + 2 + 1) = (1 + 3 + 2) = \dots

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))
