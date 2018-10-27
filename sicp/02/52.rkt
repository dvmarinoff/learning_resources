#lang racket
;; ex 02.52
;; picture language play with the language
;;
;; Make changes to the square limit of wave shown in figure 2.9
;; by working at each of the levels described above. In
;; particular:
;;
;; a. Add some segments to the primitive wave painter
;; of exercise 2.49 (to add a smile, for example).
;;
;; b. Change the pattern constructed by corner-split
;; (for example, by using only one copy of the up-split and
;; right-split images instead of two).
;;
;; c. Modify the version of square-limit that uses
;; square-of-four so as to assemble the corners in a different
;; pattern. (For example, you might make the big Mr. Rogers look
;; outward from each corner of the square.)

;; a. :) \dots

;; b.
;; (define (corner-split painter n)
;;   (if (= n 0)
;;       painter
;;       (let ((up (up-split painter (- n 1)))
;;             (right (right-split painter (- n 1))))
;;         (let ((top-left (beside up up))
;;               (bottom-right (below right right))
;;               (corner (corner-split painter (- n 1))))
;;           (beside (below painter top-left)
;;                   (below bottom-right corner))))))

(define (corner-split2 painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter (- n 1)))
            (corner (corner-split painter (- n 1))))
        (beside (below painter up)
                (below right corner)))))

;; c.
;; (define (square-limit painter n)
;;   (let ((quarter (corner-split painter n)))
;;     (let ((half (beside (flip-horiz quarter) quarter)))
;;       (below (flip-vert half) half))))

(define (square-limit painter n)
  (let ((quarter (rotate-180 (corner-split painter n))))
    (let ((half (beside (flip-horiz quarter) quarter)))
      (below (flip-vert half) half))))

;;;;
;; required code
;;;;
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
