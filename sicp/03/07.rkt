#lang racket
;; ex 03.07
;; make-joint account procedure
;;
;; Consider the bank account objects created by make-account,
;; with the password modification described in exercise 3.3.
;; Suppose that our banking system requires the ability to make
;; joint accounts. Define a procedure make-joint that
;; accomplishes this. Make-joint should take three arguments. The
;; first is a password-protected account. The second argument
;; must match the password with which the account was defined in
;; order for the make-joint operation to proceed. The third
;; argument is a new password. Make-joint is to create an
;; additional access to the original account using the new
;; password. For example, if peter-acc is a bank account with
;; password open-sesame, then
;;
;; (define paul-acc
;;   (make-joint peter-acc 'open-sesame 'rosebud))
;;
;; will allow one to make transactions on peter-acc using the
;; name paul-acc and the password rosebud. You may wish to modify
;; your solution to exercise 3.3 to accommodate this new feature.

(define (make-joint account owner-password joint-password)
  (lambda (password method)
    (cond ((eq? password joint-password)
           (account owner-password method))
          (else (lambda (x) "Incorrect password.")))))

(define peter-acc (make-account 100 'open-sesame))

(define paul-acc
  (make-joint peter-acc 'open-sesame 'rosebud))

;; ((peter-acc 'open-sesame 'deposit) 10)
;; ((paul-acc 'rosebud 'deposit) 10)
;; ((peter-acc 'open-sesame 'withdraw) 10)

(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds."))
  (define (deposit amount)
    (begin (set! balance (+ balance amount))
           balance))
  (define (auth? pass)
    (eq? password pass))
  (define (dispatch pass method)
    (cond ((not (auth? pass)) (lambda (n) "Incorrect password."))
          ((eq? method 'withdraw) withdraw)
          ((eq? method 'deposit) deposit)
          (else (error "Unknown request: MAKE-ACCOUNT" method))))
  dispatch)
