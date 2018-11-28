#lang racket
;; ex 03.20
;; environment model diagram
;;
;; Draw environment diagrams to illustrate the evaluation of the
;; sequence of expressions
;;
;; (define x (cons 1 2))
;; (define z (cons x x))
;; (set-car! (cdr z) 17)
;; (car x)
;; 17
;;
;; using the procedural implementation of pairs given above
;; (Compare exercise 3.11.)

;; box-and-pointer
;;
;; z-> [..]
;;      ||
;; x-> [..]
;;      ||
;;      12

;; environment model
;;
;; cons-> (code)(params: x y, body: ...)
;; car-> (code)(params: v, body: ...)
;; cdr-> (code)(params: v, body: ...)
;; set-car!-> (code)(params: z new-value, body: ...)
;;
;; global-> [:cons :set-car! :cdr :car :x :y]
;;
;; E1-> [x:1 y:2 set-x!: set-y!: dispatch:]
;; E2-> [x:1 y:2 set-x!: set-y!: dispatch:]
;;
;; TODO: make proper diagram
