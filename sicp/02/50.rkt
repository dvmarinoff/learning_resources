#lang racket
;; ex 02.50
;; picture language flip and rotation painters
;;
;; Define the transformation flip-horiz, which flips painters
;; horizontally, and transformations that rotate painters
;; counterclockwise by 180 degrees and 270 degrees.

(require sicp-pict)

(paint (flip-horiz einstein))

(define (flip-horiz painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)
                     (make-vect 0.0 0.0)
                     (make-vect 1.0 1.0)))

(define (rotate-180 painter)
  (transform-painter painter
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 1.0)
                     (make-vect 1.0 0.0)))

(define (rotate-270 painter)
  (transform-painter painter
                     (make-vect 0.0 1.0)
                     (make-vect 0.0 0.0)
                     (make-vect 1.0 1.0)))
