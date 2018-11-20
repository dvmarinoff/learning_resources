#lang racket
;; ex 03.04
;; add call-the-cops feature to make-account
;;
;; Modify the make-account procedure of exercise 3.3 by adding
;; another local state variable so that, if an account is
;; accessed more than seven consecutive times with an incorrect
;; password, it invokes the procedure call-the-cops.

(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds."))
  (define (deposit amount)
    (begin (set! balance (+ balance amount))
           balance))
  (define attempts 0)
  (define (get-attempts) attempts)
  (define (authorize? pass)
    (let ((auth? (eq? password pass)))
          (cond ((equal? auth? #t)
                 (begin (set! attempts 0) auth?))
                ((< attempts 3)
                 (begin (set! attempts (inc attempts)) auth?))
                (else (begin (call-the-cops) auth?)))))
  (define (call-the-cops) (display "Call the cops!"))
  (define (dispatch pass method)
    (if (authorize? pass)
        (cond ((eq? method 'withdraw) withdraw)
              ((eq? method 'deposit) deposit)
              (else (error "Unknown request: MAKE-ACCOUNT" method)))
        (lambda (n) "Incorrect password.")))
  dispatch)

(define (inc x) (+ x 1))

(define acc (make-account 100 'secret-password))
;; ((acc 'secret-password 'withdraw) 40)
;; ((acc 'wrong-password 'withdraw) 40)
