#lang racket
;; #lang htdp

;; ex. 310
;;
;; Develop count-persons. The function consumes a family tree
;; and counts the child structures in the tree.


(define-struct no-parent [])
(define NP (make-no-parent))
(define-struct child [father mother name date eyes])
;; An FT is one of
;; - NP
;; - (make-child FT FT String N String)

(define Carl (make-child NP NP "Carl" 1926 "green"))
(define Bettina (make-child NP NP "Bettina" 1926 "green"))

(define Adam (make-child Carl Bettina "Adam" 1950 "hazel"))
(define Dave (make-child Carl Bettina "Dave" 1955 "black"))
(define Eva (make-child Carl Bettina "Eva" 1965 "blue"))
(define Fred (make-child NP NP "Fred" 1966 "pink"))

(define Gustav (make-child Carl Bettina "Gustav" 1988 "brown"))

;; FT -> ???
:: ...
(define (fun-FT an-ftree)
  (cond ((no-parent? an-ftree) ...)
        (else (... (fun-FT (child-father an-ftree)) ...
               ... (fun-FT (child-mother an-ftree)) ...
               ... (child-name an-ftree) ...
               ... (child-date an-ftree) ...
               ... (child-eyes an-ftree) ...))))
