#lang racket
;; ex 03.04
;; add call-the-cops feature to make-account
;;
;; Modify the make-account procedure of exercise 3.3 by adding
;; another local state variable so that, if an account is
;; accessed more than seven consecutive times with an incorrect
;; password, it invokes the procedure call-the-cops.

(define (call-the-cops)
  ())
