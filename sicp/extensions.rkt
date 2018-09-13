#!/usr/bin/env racket
#lang racket

;; Find files in directory by extension and change the extentions
;; run with --help to see help
;; run with -i for interactive mode
;; or pass arguments:
;; --old <name of old estension to be replaced>
;; --new <name of new extension>
;; --path <path to directory>
;;
;; Example usage:
;; --old .js --new .tjs --path ./assets/js/

;; Since this is my first racket program, which I am writing while
;; going through sicp I am keeping the language close to sicp
;; chapter 2 mit-scheme

(define (rename-extensions old-ext new-ext path)
  (map (rename-extension new-ext)
       (find-files-by-extension path old-ext)))

(define (rename-extension new-ext)
  (lambda (file)
    (rename-file-or-directory
     file
     (path-replace-extension file new-ext))
    file))

(define (find-files-by-extension dir ext)
  (find-files (curryr path-has-extension? ext) dir))

(define (handle-arguments args)
  (cond ((empty? args)
         (display "no arguments run with --help \n"))
        ((equal? "-i" (first args))
         (interactive))
        ((equal? "--help" (first args))
         (help))
        ((and (member "--old" args)
              (member "--new" args)
              (member "--path" args)
              (= 6 (length args)))
         (rename-extensions (old-ext args)
                            (new-ext args)
                            (path args)))
        (else
         (args-error))))

(define (read-arguments)
  (vector->list (current-command-line-arguments)))

(define (old-ext args)
  (second args))

(define (new-ext args)
  (fourth args))

(define (path args)
  (sixth args))

(define (args-error)
  (display "wrong or no aruments run with --help"))

(define (interactive)
  (display "Interactive mode ...\nEnter old extension: ")
  (define old-ext (read-line))
  (display "Enter new extention: ")
  (define new-ext (read-line))
  (display "Enter path: ")
  (define path (read-line))
  (display (string-join (list
                         " --old " old-ext
                         " --new " new-ext
                         " --path " path
                         "\n"
                         "Continue? y/n ... ")
                        ""))
  (if (equal? (read-char) #\y)
      (rename-extensions old-ext new-ext path)
      (display "done\n")))

(define (help)
  (display (string-join
            (list
             " Usage: \n"
             "--old .js --new .tjs --path ./js/ \n\n"
             "Options: \n"
             "-i for interactive mode\n"))))

(define (main)
  (handle-arguments (read-arguments)))

(main)
