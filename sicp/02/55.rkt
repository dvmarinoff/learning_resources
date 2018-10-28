#lang racket
;; ex 02.55
;; explain double quote
;;
;; Eva Lu Ator types to the interpreter the expression
;;
;; (car ''abracadabra)
;;
;; To her surprise, the interpreter prints back quote. Explain.

(car ''abracadabra)

(car ''())
(cdr ''())

;; quote creates a list of quote and what's after the quote
;; -> '(quote abracadabra)
