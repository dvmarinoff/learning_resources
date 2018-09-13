#lang at-exp racket

;; Scaffolds a new sicp exercise with exercise and test file

;; My second racket program, so I still try to keep close to
;; sicp chapter 2 scheme, but I am using @-string exps.

(define chapter 1)
(define exercise 1)

(define (chapter-format n)
  (format "~a" n))

(define (exercise-format n)
  (if (< n 10)
      (format "0~a" n)
      (format "~a" n)))

(define (exercise-name chapter exercise)
  (format "~a.~a"
          (chapter-format chapter)
          (exercise-format exercise)))

(define (exercise-file-name exercise)
  (format "~a.rkt" (exercise-format exercise)))

(define (exercise-path-relative-to-test exercise)
  (format "../~a" (exercise-file-name exercise)))

(define (test-file-name exercise)
  (format "~a-tests.rkt" (exercise-format exercise)))

;; @-sting expression
(define template-tests @string-append{
(requre rackunit rackunit/text-ui)

(load @(format "\"~a\""
               (exercise-path-relative-to-test exercise)))

(define @(format "sicp-~a-tests" (exercise-name chapter exercise))
  (test-suite
   @(format "\"testing ~a description\""
            (exercise-name chapter exercise))

    (check-equal? (main 0) 0)
))

(run-tests @(format "sicp-~a-tests"
                    (exercise-name chapter exercise)))
})

;; @-sting expression
(define template-exercise @string-append{
;; ex @(format "~a" (exercise-name chapter exercise))
;;

})

(define (touch file-name content)
  (define out (open-output-file file-name #:exists 'truncate))
  (display content out)
  (close-output-port out))

(touch (exercise-file-name exercise) template-exercise)
(touch (test-file-name exercise) template-tests)

;; (require net/http-client)
;; (require html-parsing)

;; (define domain "mitpress.mit.edu")
;; (define book "/sites/default/files/sicp/full-text/book/")
;; (define chapter "book-Z-H-11.html")

;; (let-values (((status headers response)
;;               (http-sendrecv domain
;;                              (concat book chapter))))
;;   (html->xexp response))
