#lang racket

(require rackunit rackunit/text-ui)

(load "./27.rkt")

(define sicp-02.27-tests
  (test-suite
   "testing 02.27 deep-reverse procedure"

   (check-equal? (deep-reverse (list (list 1 2)
                                     (list 3 4)))
                 '((4 3) (2 1)))

   (check-equal? (deep-reverse (list (list 1 2)
                                     (list 3 4)
                                     (list 5 6)))
                 '((6 5) (4 3) (2 1)))

   (check-equal? (deep-reverse (list (list 1 2)
                                     (list 3 4 (list 5 6 7))
                                     (list 8   (list 9 10))))
                 '(((10 9) 8)
                   ((7 6 5) 4 3)
                   (2 1)))

   (check-equal? (deep-reverse (list
                                (list 1 2
                                      (list 3 4
                                            (list 5 6
                                                  (list 7 8))))))
                 '(((((8 7) 6 5) 4 3) 2 1)))

   ;; (check-equal? (deep-reverse-low (list (list 1 2)
   ;;                                   (list 3 4)))
   ;;               '((4 3) (2 1)))

   ;; (check-equal? (deep-reverse-low (list (list 1 2)
   ;;                                   (list 3 4)
   ;;                                   (list 5 6)))
   ;;               '((6 5) (4 3) (2 1)))

   ;; (check-equal? (deep-reverse-low (list (list 1 2)
   ;;                                   (list 3 4 (list 5 6 7))
   ;;                                   (list 8   (list 9 10))))
   ;;               '(((10 9) 8)
   ;;                 ((7 6 5) 4 3)
   ;;                 (2 1)))

   ;; (check-equal? (deep-reverse-low (list
   ;;                              (list 1 2
   ;;                                    (list 3 4
   ;;                                          (list 5 6
   ;;                                                (list 7 8))))))
   ;;               '(((((8 7) 6 5) 4 3) 2 1)))
))

(run-tests sicp-02.27-tests)
