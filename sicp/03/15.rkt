#lang racket
;; ex 03.15
;; box-and-pointer diagram for set-wow! procedure
;;
;; Draw box-and-pointer diagrams to explain the effect of set-to-wow!
;; on the structures z1 and z2 above.
;;
;; (define (set-to-wow! x) (set-car! (car x) 'wow) x)


;; [..]->[..]
;;  a     b
;;  ||
;; [..]
;; |
;; z1

;; after wow:
;; [..]->[..]
;;  wow   b
;;  ||
;; [..]
;; |
;; z1

;;  ----->[..]->[..]
;;  |      a     b
;;  |     [..]->[..]
;;  |     |
;; [..]---|
;; |
;; z2

;; after wow:
;;  ----->[..]->[..]
;;  |      a     b
;;  |     [..]->[..]
;;  |     |wow
;; [..]---|
;; |
;; z2
