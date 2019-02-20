#lang racket

(require 2htdp/universe)
(require 2htdp/image)
(require rackunit rackunit/text-ui)

;;;;
;; Selected Exercises from Part I
;;;;

; Exercise 34. Design the function string-first, which extracts the
; first character from a non-empty string. Don’t worry about empty
; strings.

; solution
; String -> String
; gets the first symbol from a string str
; given: "hello", expected: "h"
; given: "1234", expected: "1"
; given: "", expected: error
(define (string-first str)
  (cond ((not (string? str))
         (error "string-first arg is not a string"))
        ((= 0 (string-length str))
         (error "string-first called with 0 length arg"))
        (else (substring str 0 1))))

; tests
(define htdp-34
  (test-suite "HtDP, tests for ex 34"
             (test-case "works with strings of letters"
                        (check-equal? (string-first "hello") "h"))
             (test-case "works with strings of numbers"
                        (check-equal? (string-first "1234") "1"))
             (test-case "fails with non string arg"
                        (check-exn exn:fail?
                                   (lambda () (string-first 1))))
             (test-case "fails with empty string arg"
                        (check-exn exn:fail?
                                   (lambda () (string-first 1))))))

(run-tests htdp-34)

;; Exercise 35. Design the function string-last, which extracts
;; the last character from a non-empty string.

;; String -> String
;; gets the last character from a string
;; given: "hello", expect: "o"
;; given: "1234", expect: "4"
;; given: "", expect: fails
(define (string-last str)
  (cond ((not (string? str))
         (error "string-last expects a string"))
        ((= 0 (string-length str))
         (error "string-last expects a non 0 length string"))
        (else (substring str
                         (sub1 (string-length str))
                         (string-length str)))))

;; tests
(define htdp-35
  (test-suite
   "HtDP, testing ex. 35"
   (test-case
    "works on strings with letters"
    (check-equal? (string-last "hello") "o"))
   (test-case
    "works on strings with numbers"
    (check-equal? (string-last "1234") "4"))
   (test-case
    "fails on 0 length strings"
    (check-exn exn:fail? (lambda () (string-last ""))))
   (test-case
    "fails on non string args"
    (check-exn exn:fail? (lambda () (string-last 1))))))

(run-tests htdp-35)

;; Exercise 36. Design the function image-area, which counts the
;; number of pixels in a given image.

(require 2htdp/image)

;; Image -> Number
;; takes an image and counts the number of pixels
;; given: 32x32 image, expect: 1024
;; given: 320x480 image, expect: 153600
(define (image-area img)
  (cond ((not (image? img))
         (error "image-area expects an image"))
        (else (* (image-width img)
                 (image-height img)))))

;; tests
(define htdp-36
  (test-suite
   "Tests HtDP, ex. 36"
   (test-case
    "works with Images"
    (define ICON (square 32 "solid" "green"))
    (define SCREEN (rectangle 320 480 "solid" "green"))

    (check-equal? (image-area ICON) 1024)
    (check-equal? (image-area SCREEN) 153600))
   (test-case
    "fails with non image arg"
    (check-exn exn:fail? (lambda () (image-area 1))))
   ))

(run-tests htdp-36)

;; Exercise 37. Design the function string-rest, which produces a
;; string like the given one with the first character removed

;; String -> String
;; returns the tail of the string
;; given: "hello", expect: "ello"
;; given: "1234", expect: "234"
;; given: "a", expect: ""
;; given: "", expect: fails
(define (string-rest str)
  (cond ((not (string? str))
         (error "string-rest expects a string arg"))
        ((= 0 (string-length str))
         (error "string-rest called with a 0 length string"))
        (else (substring str 1))))

;; tests
(define htdp-37
  (test-suite
   "Testing HtDP, ex. 37"
   (test-case
    "works with strings"
    (check-equal? (string-rest "hello") "ello")
    (check-equal? (string-rest "1234") "234"))
   (test-case
    "works with strings of length 1"
    (check-equal? (string-rest "h") ""))
   (test-case
    "fail with non string input"
    (check-exn exn:fail? (lambda () (string-rest 1))))
   (test-case
    "fail with string of length 0"
    (check-exn exn:fail? (lambda () (string-rest ""))))))

(run-tests htdp-37)

;; Exercise 38. Design the function string-remove-last, which
;; produces a string like the given one with the last character
;; remove.

;; String -> String
;; returns new string without the last character of str
;; given: "hello", expect: "hell"
;; given: "1234", expect: "123"
(define (string-remove-last str)
  (cond ((not (string? str))
         (error "string-remove-last expects a string input"))
        ((= 0 (string-length str))
         (error "string-remove-last called with 0 length string"))
        (else (substring str 0 (sub1 (string-length str))))))


;; tests
(define htdp-38
  (test-suite
   "Testing HtDP, ex 38"
   (test-case
    "works with strings"
    (check-equal? (string-remove-last "hello") "hell")
    (check-equal? (string-remove-last "1234") "123"))
   (test-case
    "works with strings of length 1"
    (check-equal? (string-remove-last "h") "")
    (check-equal? (string-remove-last "1") ""))
   (test-case
    "fails with strings of length 0"
    (check-exn exn:fail? (lambda () (string-remove-last ""))))
   (test-case
    "fails with non string input"
    (check-exn exn:fail? (lambda () (string-remove-last 1))))))

(run-tests htdp-38)

;; Exercise 39. Good programmers ensure that an image such as CAR
;; can be enlarged or reduced via a single change to a constant
;; definition (Good programmers establish a single point of
;; control for all aspects of their programs, not just the
;; graphical constants. Several chapters deal with this issue).
;; We started the development of our car image with a single plain
;; definition:

;; (define WHEEL-RADIUS 5)

;; The definition of WHEEL-DISTANCE is based on the wheel’s
;; radius. Hence, changing WHEEL-RADIUS from 5 to 10 doubles the
;; size of the car image. This kind of program organization is
;; dubbed single point of control, and good design employs this
;; idea as much as possible.

;; Develop your favorite image of an automobile so that
;; WHEEL-RADIUS remains the single point of control.

(define WIDTH-OF-WORLD 200)
(define WHEEL-RADIUS 5)

(define wheel (circle WHEEL-RADIUS "solid" "black"))
(define space (rectangle WHEEL-RADIUS
                         (/ WHEEL-RADIUS 2) "solid" "white"))
(define wheels (beside wheel space wheel))
(define body (above
              (rectangle (* 4 WHEEL-RADIUS)
                         WHEEL-RADIUS "solid" "red")
              (rectangle (* 7 WHEEL-RADIUS)
                         (* 2 WHEEL-RADIUS) "solid" "red")))

(define vehicle (overlay/xy wheels
                        (- 0 WHEEL-RADIUS) (* -2 WHEEL-RADIUS)
                        body))

(define background (rectangle WIDTH-OF-WORLD 50 "outline" "black"))

(define (scene x) (overlay/xy vehicle (- 0 x) -30 background))

(define (main init)
  (big-bang init
            (to-draw render)))

(main 0)

;; Exercise 43. Let’s work through the same problem statement
;; with a time-based data definition:
;;
;;  ; An AnimationState is a Number.
;;  ; interpretation the number of clock ticks
;;  ; since the animation started
;;
;; Like the original data definition, this one also equates the
;; states of the world with the class of numbers. Its
;; interpretation, however, explains that the number means
;; something entirely different.
;;
;; Design the functions tock and render. Then develop a big-bang
;; expression so that once again you get an animation of a car
;; traveling from left to right across the world’s canvas.
;;
;; How do you think this program relates to animate from
;; Prologue: How to Program?
;;
;; Use the data definition to design a program that moves the car
;; according to a sine wave. (Don’t try to drive like that.)

;; the car
(define vehicle (bitmap/file "../images/car.png"))

;; just the background scene
(define background (rectangle 200 50 "outline" "black"))

;; Number -> Image
;; gets a number for x-pos of the car relative to the background
;; and draws the whole thing
(define (scene x) (overlay/xy vehicle (- 0 x) -30 background))

;; Number -> Number
;; the function to update the x-pos of the car
(define (update x)
  (abs (* 100 (sin x))))

(define (reach-end? x)
  (>= x (- WIDTH-OF-WORLD width-of-vehicle)))

(define (main init)
  (big-bang init
            (stop-when reach-end?)
            (on-tick update)
            (to-draw render)))

(main 1)

;; Exercise 44. Formulate the examples as BSL tests. Click RUN
;; and watch them fail.
;;
;; Continued from:
;;
;; Sample Problem Design a program that moves a car across the
;; world canvas, from left to right, at the rate of three pixels
;; per clock tick. If the mouse is clicked anywhere on the
;; canvas, the car is placed at the x-coordinate of that click.

;; constants
(define WIDTH-OF-WORLD 400)
(define WHEEL-RADIUS 5)
(define width-of-vehicle (* 7 WHEEL-RADIUS))
;; the car
(define vehicle (bitmap/file "../images/car.png"))

;; just the background scene
(define background (rectangle WIDTH-OF-WORLD 50 "outline" "black"))

;; Number -> Image
;; gets a number for x-pos of the car relative to the background
;; and draws the whole thing
(define (scene x) (overlay/xy vehicle (- 0 x) -30 background))

;; Number -> Number
;; the function to update the x-pos of the car
(define (update x)
  (+ x 3))

;; WorldState Number Number String -> WorldState
;; place the car at x-mouse
;; if the given me is "button-down"
(define (hyper x-pos-car x-mouse y-mouse me)
  (if (equal? me "button-down")
      x-mouse
      x-pos-car))

(define (reach-end? x)
  (>= x (- WIDTH-OF-WORLD width-of-vehicle)))

(define (main init)
  (big-bang init
            ;; (stop-when reach-end?)
            (on-tick update)
            (to-draw scene)
            (on-mouse hyper)))

(main 0)

;; Exercise 45. Design a “virtual cat” world program that
;; continuously moves the cat from left to right. Let’s call it
;; cat-prog and let’s assume it consumes the starting position of
;; the cat. Furthermore, make the cat move three pixels per clock
;; tick. Whenever the cat disappears on the right, it reappears
;; on the left. You may wish to read up on the modulo function.

(define cat1 (bitmap/file "../images/cat1.png"))
(define cat2 (bitmap/file "../images/cat2.png"))

(define room (rectangle (* 10 (cat-width cat1))
                        (double (cat-height cat1))
                        "outline"
                        "black"))

;; Image -> Number
(define (cat-height cat) (image-height cat))
;; Image -> Number
(define (cat-width cat) (image-width cat))
;; Number -> Image
(define (cat-switch x) (if (odd? x) cat1 cat2))
;; Image -> Number
(define (room-width room) (image-width room))
;; Number -> Number
(define (double x) (* 2 x))

(define (render x)
  (overlay/xy room x (* 1 (cat-height cat1)) (cat-switch x)))

;; Number -> Number
;; move the cat to the right end with 3px
;; repeat from the start
(define (update x)
  (cond ((reach-end? x) 0)
        (else (+ 3 x))))

;; Number -> Boolean
(define (reach-end? cat-x)
  (>= cat-x (room-width room)))

(main 0)

(define (main init-x)
  (big-bang init-x
            (on-tick update)
            (to-draw render)))

;; tests
(define htdp-45
  (test-suite
   "Testing HtDP ex. 45"
   ;; "increments with 3"
   (check-equal? (update 0) 3)
   (check-equal? (update 3) 6)
   ;;  "resets to 0"
   (check-equal? (update (room-width room)) 0)
   (check-equal? (update (+ 1 (room-width room))) 0)

   ;;
   (check-true (reach-end? (room-width room)))
   (check-true (reach-end? (+ 1 (room-width room))))
   (check-false (reach-end? 0))
   (check-false (reach-end? 3))
   (check-false (reach-end? -3))

   (check-equal? (cat-switch 3) cat1)
   (check-equal? (cat-switch 6) cat2)
   ))

(run-test htdp-45)

;; Exercise 47. Design a world program that maintains and
;; displays a “happiness gauge.” Let’s call it gauge-prog, and
;; let’s agree that the program consumes the maximum level of
;; happiness. The gauge display starts with the maximum score,
;; and with each clock tick, happiness decreases by -0.1; it
;; never falls below 0, the minimum happiness score. Every time
;; the down arrow key is pressed, happiness increases by 1/5;
;; every time the up arrow is pressed, happiness jumps by 1/3.

;; To show the level of happiness, we use a scene with a solid,
;; red rectangle with a black frame. For a happiness level of 0,
;; the red bar should be gone; for the maximum happiness level of
;; 100, the bar should go all the way across the scene.

;; Note: When you know enough, we will explain how to combine the
;; gauge program with the solution of exercise 45. Then we will
;; be able to help the cat because as long as you ignore it, it
;; becomes less happy. If you pet the cat, it becomes happier. If
;; you feed the cat, it becomes much, much happier. So you can
;; see why you want to know a lot more about designing world
;; programs than these first three chapters can tell you.

(define maximum-happiness 100)
(define minimum-happiness 0)

;; Number, Number, Number -> WorldState -> Image
;; takes width and height for the bar dimensions
;; and returns a function that takes the value
;; from the WorldState for the bar level
(define (happiness-bar width height)
  (define border 1)
  (define background
    (rectangle (+ border width) (+ border height) "outline" "black"))
  (define (bar x)
    (rectangle x height "solid" "red"))
  (lambda (x)
    (overlay/align "middle" "middle"
                   (text (format-bar-value x) 14 "black")
                   (overlay/xy (bar x)
                               (- border) (- border)
                               background))))

(define (format-bar-value x)
  (~r x #:precision 0  #:min-width 3))

(define (render x)
  ((happiness-bar maximum-happiness (/ maximum-happiness 3)) x))

;; Number -> Number
;; decrease happiness with 0.1 until 0
(define (decrease-happiness x)
  (if (<= x 0.1) 0 (- x 0.1)))

;; Number -> Number
;; increase happiness x with value until maximum
(define (increase-happiness x value)
  (let ((increase (exact->inexact value)))
    (if (<= (+ x increase) maximum-happiness)
        (+ x increase)
        maximum-happiness)))

;; WorldState, Key -> WorldState
;; on up arraw increase happiness with 1/5
;; on down arraw increase happiness with 1/3
(define (key-press-handler x key)
  (cond ((key=? key "up") (increase-happiness x 1/5))
        ((key=? key "down") (increase-happiness x 1/3))
        (else x)))

(define (main init-happiness)
  (big-bang init-happiness
            (to-draw render)
            (on-tick decrease-happiness)
            (on-key key-press-handler)))

(main 100)

;; tests
(define htdp-47
  (test-suite
   "Testing HtDP ex. 47"
   (check-equal? (decrease-happiness 100) 99.9)
   (check-equal? (decrease-happiness 0.1) 0)
   (check-equal? (decrease-happiness 0) 0)

   (check-equal? (increase-happiness 1 1/5) 1.2)
   (check-equal? (increase-happiness 99 1/5) 99.2)
   (check-equal? (increase-happiness 99.8 1/5) 100.0)
   (check-equal? (increase-happiness 99.9 1/5) 100)

   (check-equal? (format-bar-value 0)        "  0")
   (check-equal? (format-bar-value 10)       " 10")
   (check-equal? (format-bar-value 10.4)     " 10")
   (check-equal? (format-bar-value 100.0)    "100")
   (check-equal? (format-bar-value 100.1234) "100")
   ))

(run-tests htdp-47)

;; Exercise 75. Enter these definitions and their test cases into
;; the definitions area of DrRacket and make sure they work. This
;; is the first time that you have dealt with a “wish,” and you
;; need to make sure you understand how the two functions work
;; together.


;; TODO:

;; Exercise 102. Design all other functions that are needed to
;; complete the game for this second data definition.

(define tank-image (bitmap "../images/tank.png"))
(define ufo-image (bitmap "../images/alien.png"))
(define missle-image (bitmap "../images/missle.png"))

(define tank-height (image-height tank-image))
(define tank-width (image-width tank-image))

(define map (empty-scene map-width map-height))
(define map-width 300)
(define map-height 300)

(struct aim (ufo tank))
(struct fired (ufo tank missle))

(struct pos (x y)	#:transparent)

;; A UFO is a Pos.
;; interpretation (pos x y) is the UFO's location
;; (using the top-down, left-to-right convention)

(struct tank (loc vel))
;; A Tank is a structure:
;;   (make-tank Number Number).
;; interpretation (make-tank x dx) specifies the position:
;; (x, HEIGHT) and the tank's speed: dx pixels/tick

;; A Missle is a Pos.
;; interpretation (make-pos x y) is the missle's place

;; A SIGS is one of:
;; - (make-aim UFO Tank)
;; - (make-fired UFO Tank Missle)
;; interpretation represents the complete state of a
;; space invader game



;; NOTE:
;; Information -> Data -> Representation -> Design Recipe
;; Tank, Ufo, maybe Missle, Pos
;; - Tank - location: x, y pos, velocity: number
;; - Ufo - x, y pos
;; - Missle - x, y pos
;; - Pos - number, number
;;
;; We may represent the maybe missle with state itemization:
;; game state is one of aim state or fired state
;;
;; Or with passing a boolean for missleOrNot
;;
;; We choose the 1st approach here
;; 1. Write down the constants
;; 2. Create the game objects (structs with examples)
;; 3. Give examples for game state
;; 4. From those start the design for the big-bang functions.
;;    The data choices will dictate the structure of conds
;;
;; 2 possible kinds of data -> 2 clauses
;; 2 or 3 fields in a data structure -> 2/3 selectors
;; - 1st case: renders 2 ojects with custom data definitions
;;    -> needs 2 auxilary functions to render
;; - 2nd case: 3 objects -> 3 auxilary functions

(define (main init)
  (big-bang init
            (stop-when game-over?)
            (to-draw render)
            (on-tick move)
            (on-key control)))

(main init-sigs)

(render (aim (pos 150 15) (tank (pos 150 280) 10)))
(render (fired (pos 150 15)
               (tank (pos 150 280) 10)
               (pos 150 150)))

;; SIGS -> IMAGE
(define (render s)
  (cond ((aim? s)
         (tank-render (aim-tank s)
                      (ufo-render (aim-ufo s) map)))
        ((fired? s)
         (tank-render (fired-tank s)
                      (ufo-render (fired-ufo s)
                                  (missle-render (fired-missle s)
                                                 map))))
        (else (error "render called with unknown state"))))

;; Tank Image -> Image
(define (tank-render t img)
  (place-image tank-image
               (pos-x (tank-loc t))
               (pos-y (tank-loc t)) img))

;; UFO Image -> Image
(define (ufo-render u img)
  (place-image ufo-image (pos-x u) (pos-y u) img))

;; Missle Image -> Image
(define (missle-render m img)
  (place-image missle-image (pos-x m) (pos-y m) img))

;; SIGS -> Boolean
(define (game-over? s))

;; SIGS -> SIGS
(define (move s))

;; Number -> Number
(define (random n))

;; Key SIGS -> SIGS
(define (control key s)
  (cond ((key=? "left" key) (.))
        ((key=? "right" key) (.))
        ((key=? "space" key) (.))
        (else (error "control: called with unknown key"))))

;;;;
;; tests
;;;;
(require rackunit rackunit/text-ui)

(define invaders-tests
  (test-suite
   "Testing the space invaderes game (the book version)"

   (check-equal? 1 1)

   ))

(run-tests invaders-tests)
