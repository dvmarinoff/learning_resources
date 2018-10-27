#lang racket
;; ex 02.49
;; picture language segments->painter
;;
;; Use segments->painter to define the following primitive
;; painters:
;;
;; a. The painter that draws the outline of the
;; designated frame.
;;
;; b. The painter that draws an ``X'' by connecting opposite
;; corners of the frame.
;;
;; c. The painter that draws a diamond shape by connecting the
;; midpoints of the sides of the frame.
;;
;; d. The wave painter.

(require sicp-pict)

(define outline (list (make-segment (make-vect 0 0)
                                    (make-vect 0.99 0))
                      (make-segment (make-vect 0.99 0)
                                    (make-vect 0.99 0.99))
                      (make-segment (make-vect 0.99 0.99)
                                    (make-vect 0 0.99))
                      (make-segment (make-vect 0 0.99)
                                    (make-vect 0 0))))

(define cross (list (make-segment (make-vect 0 0)
                                    (make-vect 1 1))
                      (make-segment (make-vect 0 1)
                                    (make-vect 1 0))))

(define diamond (list (make-segment (make-vect 0.5 0)
                                    (make-vect 1 0.5))
                      (make-segment (make-vect 1 0.5)
                                    (make-vect 0.5 1))
                      (make-segment (make-vect 0.5 1)
                                    (make-vect 0 0.5))
                      (make-segment (make-vect 0 0.5)
                                    (make-vect 0.5 0))))

(define wave (list
                   ;; inner legs
                   (make-segment (make-vect 0.4 0)
                                 (make-vect 0.5 0.3))
                   (make-segment (make-vect 0.6 0)
                                 (make-vect 0.5 0.3))

                   ;; outer legs
                   (make-segment (make-vect 0.25 0)
                                 (make-vect 0.35 0.5))
                   (make-segment (make-vect 0.75 0)
                                 (make-vect  0.65 0.5))

                   ;; head
                   (make-segment (make-vect 0.4 1)
                                 (make-vect 0.35 0.9))
                   (make-segment (make-vect 0.6 1)
                                 (make-vect 0.65 0.9))
                   (make-segment (make-vect 0.35 0.9)
                                 (make-vect 0.4 0.80))
                   (make-segment (make-vect 0.65 0.9)
                                 (make-vect 0.6 0.80))

                   ;; right shoulder
                   (make-segment (make-vect 0.4 0.80)
                                 (make-vect 0.3 0.80))

                   ;; right arm
                   (make-segment (make-vect 0.3 0.80)
                                 (make-vect 0.17 0.7))
                   (make-segment (make-vect 0.17 0.7)
                                 (make-vect 0 0.9))

                   (make-segment (make-vect 0.3 0.70)
                                 (make-vect 0.17 0.5))
                   (make-segment (make-vect 0.17 0.5)
                                 (make-vect 0 0.75))

                   ;; back right
                   (make-segment (make-vect 0.3 0.70)
                                 (make-vect 0.35 0.5))

                   ;; left shoulder
                   (make-segment (make-vect 0.6 0.80)
                                 (make-vect 0.75 0.80))

                   ;; left arm
                   (make-segment (make-vect 0.75 0.80)
                                 (make-vect 1 0.4))

                   (make-segment (make-vect 0.65 0.5)
                                 (make-vect 1 0.2))
                      ))

(paint (segments->painter frame))
(paint (segments->painter cross))
(paint (segments->painter diamond))
(paint (segments->painter wave))
