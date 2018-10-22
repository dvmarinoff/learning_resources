#lang racket

(require rackunit rackunit/text-ui)

(load "./29.rkt")

(define sicp-02.29-tests
  (test-suite
   "testing 02.29 a binary mobile"

    (check-equal? (left-branch (make-mobile (make-branch 1 2)
                                            (make-branch 3 4)))
                  (make-branch 1 2))

    (check-equal? (right-branch (make-mobile (make-branch 1 2)
                                             (make-branch 3 4)))
                  (make-branch 3 4))

    (check-equal? (branch-length (make-branch 1 2))
                  1)

    (check-equal? (branch-structure (make-branch 1 2))
                  2)

    (check-equal? (total-weight m0) 0)
    (check-equal? (total-weight m1) 4)
    (check-equal? (total-weight m3) 8)

    (check-true (balanced? m1))
    (check-false (balanced? m2))
    (check-true (balanced? m3))
    (check-false (balanced? m4))
    (check-true (balanced? m7))


    (check-true
     (balanced? (make-mobile
                 (make-branch 3 (make-mobile
                                 (make-branch 2 4)
                                 (make-branch 8 1)))
                             (make-branch 5 3))))

    (check-false
     (balanced? (make-mobile
                 (make-branch 3 (make-mobile
                                 (make-branch 2 4)
                                 (make-branch 7 1)))
                             (make-branch 5 3))))
))

(run-tests sicp-02.29-tests)
