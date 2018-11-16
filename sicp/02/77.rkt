#lang racket
;; ex 02.77
;; explain interfacing to lower level packages
;;
;; Louis Reasoner tries to evaluate the expression (magnitude z)
;; where z is the object shown in Figure 2.24. To his surprise,
;; instead of the answer 5 he gets an error message from
;; apply-generic , saying there is no method for the operation
;; magnitude on the types (complex) . He shows this interaction
;; to Alyssa P. Hacker, who says the problem is that the
;; complex-number selectors were never defined for complex
;; numbers, just for polar and rectangular numbers. All you have
;; to do to make this work is add the following to the complex
;; package:
;;
;; (put 'real-part '(complex) real-part)
;; (put 'imag-part '(complex) imag-part)
;; (put 'magnitude '(complex) magnitude)
;; (put 'angle '(complex) angle)

(magnitude z)
(magnitude (make-complex-from-real-imag 3 4))
;; -> dispatch get 'make-from-real-imag 'complex -> apply
(make-from-real-imag 3 4)
;; -> dispatch get 'make-from-real-imag 'rectangular -> apply
(magnitude (make-from-real-imag 3 4))
;; -> dispatch get 'magnitude 'complex -> apply
5

;; Assuming that the number z is already constructed apply
;; has been called twice.




