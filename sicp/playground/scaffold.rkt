#lang at-exp racket

(require "fold.rkt")

;; Scaffolds a new sicp exercise with exercise and test file

;; My second racket program, so I still try to keep close to
;; sicp chapter 1 scheme, but I am using @-string exps and
;; command-line parser from racket.

(define chapter (make-parameter 1))
(define exercise (make-parameter 1))
(define tests (make-parameter #t))
(define description (make-parameter "description"))

(define parser
  (command-line
   #:usage-help
   "Scaffold creates and fills in with some starter code"
   "files for sicp exercises and their unit tests."

   #:once-each
   [("-c" "--chapter") CHAPTER
    "the chapter number as an integer"
    (chapter (string->number CHAPTER))]

   [("-e" "--exercise") EXERCISE
    "the exercice number as an integer"
    (exercise (string->number EXERCISE))]

   [("-t" "--tests") TESTS
    "boolean include a test file or not default is true"
    (tests (string=? "t" TESTS))]

   [("-d" "--description") DESCRIPTION
    "exercise short description for test file"
    (description DESCRIPTION)]

   #:args () (void)))

(define (pad-a-zero n)
  (if (< n 10)
      (format "0~a" n)
      (format "~a" n)))

(define (exercise-format n)
  (pad-a-zero n))

(define (chapter-format n)
  (pad-a-zero n))

(define (exercise-name chapter exercise)
  (format "~a.~a"
          (chapter-format chapter)
          (exercise-format exercise)))

(define (exercise-file-name exercise)
  (format "~a.rkt" (exercise-format exercise)))

(define (exercise-file-path exercise-file-name chapter-format)
  (define chapter-path (format "./~a" chapter-format))
  (unless (directory-exists? chapter-path)
    (make-directory chapter-path))
  (format "~a/~a" chapter-path exercise-file-name))

(define (exercise-path-relative-to-test exercise)
  (format "../~a" (exercise-file-name exercise)))

(define (test-file-name exercise)
  (format "~a-tests.rkt" (exercise-format exercise)))

(define (test-file-path test-file-name chapter-format)
  (define chapter-test-dir (format "./~a/tests/" chapter-format))
  (unless (directory-exists? chapter-test-dir)
      (make-directory chapter-test-dir))
  (format "~a~a" chapter-test-dir  test-file-name))

(define (touch file-name content)
  (define out (open-output-file file-name #:exists 'truncate))
  (display content out)
  (close-output-port out))

;; begin @-sting expression
(define template-tests @string-append{
#lang racket

(require rackunit rackunit/text-ui)

(load @(format "\"~a\""
               (exercise-path-relative-to-test (exercise))))

(define @(format "sicp-~a-tests" (exercise-name
                                  (chapter)
                                  (exercise)))
  (test-suite
   @(format "\"testing ~a ~a\""
            (exercise-name (chapter) (exercise)) (description))

    (check-equal? (main 0) 0)
))

(run-tests @(format "sicp-~a-tests"
                    (exercise-name (chapter) (exercise))))

})
;; end

;; begin @-sting expression
(define template-exercise @string-append{
#lang racket
;; ex @(format "~a" (exercise-name (chapter) (exercise)))
;; @(format "~a" (description))

(define (main n) n)

})
;; end

(define (main)
  (touch (exercise-file-path (exercise-file-name (exercise))
                             (chapter-format (chapter)))
         template-exercise)
  (when (equal? #t (tests))
    (touch (test-file-path (test-file-name (exercise))
                           (chapter-format (chapter)))
           template-tests)))

(main)
