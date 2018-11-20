#lang racket

(require rackunit rackunit/text-ui)

(load "../04.rkt")

(define sicp-03.04-tests
  (test-suite
   "testing 03.04 add call-the-cops feature to make-account"

    (check-equal? ((acc 'secret-password 'withdraw) 40) 60)
    (check-equal? ((acc 'secret-password 'withdraw) 120)
                  "Insufficient funds.")
    (check-equal? ((acc 'secret-password 'deposit) 40) 100 "deposit")

    (check-equal? ((acc 'wrong-password 'withdraw) 40)
                  "Incorrect password."
                  "pass fail")
))

(run-tests sicp-03.04-tests)
