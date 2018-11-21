#lang racket
;; ex 03.12
;; box-pointer diagrams for append and append!
;;
;; the following procedure for appending lists was introduced in
;; Section 2.2.1:
;;
;; (define (append x y)
;;   (if (null? x) y (cons (car x)
;;                         (append (cdr x) y))))
;;
;; forms a new list by successively cons ing the elements of x
;; onto y. The procedure append! is similar to append, but it is
;; a mutator rather than a constructor. It appends the lists by
;; splicing them together, modifying the final pair of x so
;; that its cdr is now y. (It is an error to call append! with
;; an empty x.)
;;
;; (define (append! x y)
;;   (set-cdr! (last-pair x) y)
;;   x)
;;
;; Here last-pair is a procedure that returns the last pair in
;; its argument:
;;
;; (define (last-pair x)
;;   (if (null? (cdr x)) x (last-pair (cdr x))))
;;
;; Consider the interaction
;;
;; (define x (list 'a 'b))
;; (define y (list 'c 'd))
;; (define z (append x y))
;; z
;; (a b c d)
;; (cdr x)
;; ⟨ response ⟩
;;
;; (define w (append! x y))
;; w
;; (a b c d)
;; (cdr x)
;; ⟨ response ⟩
;;
;; What are the missing ⟨ response ⟩s? Draw box-and-pointer
;; diagrams to explain your answer.

;;;;
;; Solution
;;;;

;; starting point:
;; [..]->[.\]  [..]->[.\]
;;  a     b     c     d
;; x           y

;; first append:
;; (a b c d)
;; -> (b)
;;
;; [..]->[..]->[..]->[.\]
;;  a     b     c     d
;; |           |
;; z           y

;; second append!
;; -> (b c d)
;;
;; x
;; |
;; [..]->[..]->[..]->[.\]
;;  a     b     c     d
;; |           |
;; w           y
