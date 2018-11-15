#lang racket
;; ex 02.74
;; data-directed programming Insatiable Enterprises, Inc.
;;
;; Insatiable Enterprises, Inc., is a highly decentralized
;; conglomerate company consisting of a large number of
;; independent divisions located all over the world. The company’s
;; computer facilities have just been interconnected by means of
;; a clever network-interfacing scheme that makes the entire
;; network appear to any user to be a single computer.
;; Insatiable’s president, in her first atempt to exploit the
;; ability of the network to extract administrative information
;; from division files, is dismayed to discover that, although
;; all the division files have been implemented as data
;; structures in Scheme, the particular data structure used
;; varies from division to division. A meeting of division
;; managers is hastily called to search for a strategy to
;; integrate the files that will satisfy headquarters’ needs
;; while preserving the existing autonomy of the divisions. Show
;; how such a strategy can be implemented with data-directed
;; programming. As an example, suppose that each division’s
;; personnel records consist of a single file, which contains a
;; set of records keyed on employees’ names. The structure of the
;; set varies from division to division. Furthermore, each
;; employee’s record is itself a set (structured differently from
;; division to division) that contains information keyed under
;; identifiers such as address and salary . In particular:
;;
;; a. Implement for headquarters a get-record procedure that
;; retrieves a specified employee’s record from a specified
;; personnel file. The procedure should be applicable to any
;; division’s file. Explain how the individual divisions’ files
;; should be structured. In particular, what type information
;; must be supplied?
;;
;; b. Implement for headquarters a get-salary procedure that
;; returns the salary information from a given employee’s record
;; from any division’s personnel file. How should the record be
;; structured in order to make this operation work?
;;
;; c. Implement for headquarters a find-employee-record
;; procedure. This should search all the divisions’ files for the
;; record of a given employee and return the record. Assume that
;; this procedure takes as arguments an employee’s name and a
;; list of all the divisions’ files.
;;
;; d. When Insatiable takes over a new company, what changes must
;; be made in order to incorporate the new personnel
;; information into the central system?

;; Divisions:
;; '('Hurricanes 'Crusaders 'Highlanders)
;;
;; Division Hurricanes record:
;; '("Baret" '('address "Wellington 10" 'salary 1000))
;;
;; Division Highlanders record:
;; '(("Smith") '(('address "Dunedin 15") ('salary 1000)))

(define file1 '(("Baret" ('address "Wellington 10" 'salary 1000))
                ("Perenara" ('address "Wellington 9" 'salary 900))
                ("Savea" ('address "Wellington 7" 'salary 800))))

(define file2 '((("Smith")
                 (('address "Dunedin 15") ('salary 1000)))
                (("Sopoaga")
                 (('address "Dunedin 10") ('salary 900)))
                (("Naholo")
                 (('address "Dunedin 11") ('salary 800)))))

(define hurricanes (attach-tag 'hurricanes file1))
(define highlanders (attach-tag 'highlanders file2))

;; a.
(define (get-record-hurricanes name file)
  (let ((record (filter
                 (lambda (record) (eq? (car record) name))
                 file)))
    (if (pair? record)
        (car record)
        ("record not found"))))

(define (get-record-highlanders name file)
  (let ((record (filter
                 (lambda (record) (eq? (car (car record)) name))
                 file)))
    (if (pair? record)
        (car record)
        ("record not found"))))

(define (tag x) (attach-tag 'hurricanes x))
;; (define (tag x) (attach-tag 'highlanders x))

(define types-operations-mapping (make-hash))
(inspect-table)

(put 'get-record
     '(string hurricanes)
     (lambda(name file)
       (tag (get-record-hurricanes name file))))

(put 'get-record
     '(string highlanders)
     (lambda(name file)
       (get-record-highlanders name file)))

;; note: apply-generic requires all args to be type tagged,
;; hence the need to add the 'string tag to name
(define (get-record name file)
  (apply-generic 'get-record (attach-tag 'string name) file))

(get-record "Baret" hurricanes)
(get-record "Smith" highlanders)

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (display (format "~a \n type-tags: ~a \n proc: ~a \n" args type-tags proc))
      (if proc
          (apply proc (map contents args))
          (error "No method for these types - APPLY-GENERIC"
                 (list op type-tags))))))

;; b.
(define (get-salary record)
  (apply-generic 'get-salary record))

(define (get-salary-hurricanes record)
  (car (cdddr (car (cddr record)))))

(define types-operations-mapping (make-hash))
(inspect-table)

(put 'get-salary
     '(hurricanes)
     (lambda (name file)
       (get-salary-hurricanes name file)))

(get-salary (get-record "Baret" hurricanes))
(car (cdddr (car (cddr (get-record "Baret" hurricanes)))))

;; c.
;; (define (find-employee-record name divisions)
;;   (generic-apply 'find-employee-record '(string name) divisions))
(define devisions (list hurricanes highlanders))

(define (find-employee-record name divisions)
  (let ((record (get-record name (car divisions))))
    (if (pair? record)
        record
        (find-employee-record name (cdr devisions)))))

;; d.
(define (install-package-hurricanes)
  (define (get-record name file)
    (let ((record (filter
                   (lambda (record) (eq? (car record) name))
                   file)))
      (if (pair? record)
          (car record)
          ("record not found"))))
  (define (get-salary record)
    (car (cdddr (car (cddr record)))))
  (define (tag x) (attach-tag 'hurricanes x))

  (put 'get-record
       '(string hurricanes)
       (lambda(name file)
         (tag (get-record name file))))
  'done)

(define (install-package-highlanders)
  (define (get-record name file)
    (let ((record (filter
                   (lambda (record) (eq? (car (car record)) name))
                   file)))
      (if (pair? record)
          (car record)
          ("record not found"))))
  (define (get-salary record)
    (car (cdddr (car (cddr record)))))
  (define (tag x) (attach-tag 'highlanders x))

  (put 'get-record
       '(string highlanders)
       (lambda(name file)
         (tag (get-record name file))))
  'done)

;;;;
;; Required code
;;;;

;; type container
(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum: TYPE-TAG" datum)))

(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum: CONTENTS" datum)))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error "No method for these types - APPLY-GENERIC"
                 (list op type-tags))))))

;; table
(define (put op type item)
  (hash-set! types-operations-mapping (list op type) item))

(define (get op type)
  (hash-ref types-operations-mapping (list op type)))

(define (inspect-table)
  (display types-operations-mapping))
