#lang racket
;; ex 02.76
;; compare the 3 strategies for systems with generic operations
;;
;; As a large system with generic operations
;; evolves, new types of data objects or new operations may
;; be needed. For each of the three strategies—generic operations
;; with explicit dispatch, data-directed style, and message-
;; passing-style — describe the changes that must be made to a
;; system in order to add new types or new operations. Which
;; organization would be most appropriate for a system in
;; which new types must often be added? Which would be
;; most appropriate for a system in which new operations
;; must often be added?

;; explicit-dispatch
;; the operations must know about all the types in the system,
;; so when adding new type you would have to change all of the
;; operations.

;; message-passing-style
;; the types know about the operations, so when adding a new
;; operation you must change all the types.

;; data-directed programming
;; types and operations are contained inside the packages and
;; you will have to do some work when adding new operation or
;; new type, but you won't need to change all the types or all the
;; operations. There is some maintanance required about the whole
;; process and it might get complex, but is the most flexible
;; strategy of the three.

(define (main n) n)
