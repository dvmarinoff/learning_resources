;; NOTE: I am using this ex. just as place where to play with
;; the universe library and do the alien invasion game.
;;
;; It is not the full game as it is limited to concepts from
;; part I!

;; NOTE:
;; an agent controlling the tank needs to pick:
;; 1. move: right, left, *stay
;; 2. fire
;; 3*. sleep
;;
;; an agent controlling the alien needs to pick:
;; 1. direction: left, right, *stay
;;
;; it is both easier to train or to program the alien

(require 2htdp/universe)
(require 2htdp/image)

(define tank-image (bitmap "../images/tank.png"))
(define alien-image (bitmap "../images/alien.png"))
(define missle-image (bitmap "../images/missle.png"))
(define battleground (empty-scene 300 300))

;; position
(struct pos (x y))
;; moves top to bottom and sideways
(struct alien (pos step))
;; moves bottom up
(struct missle (pos step))
;; moves left to right and back
(struct tank (pos step))
;; where is stuff(that changes) on the map at each tick
(struct state (tank alien missle))

;; the size of the sideways step of the alien
(define game-difficulty 10)

(define tank1 (tank (pos 100 (- (image-height battleground)
                                (image-height tank-image))) 10))
(define alien1 (alien (pos 100 10) 1))
(define missle1 (missle (pos 100 270) 0))
(define missle0 (missle (pos -10 -10) 0))

(define init-state (state tank1 alien1 missle0))

(define (main init)
  (big-bang init
            (stop-when end-game?)
            (on-tick update)
            (to-draw render)
            (on-key handle-key-press)))

(main init-state)

;; WorldState -> Boolean
;; has the alien landed (reached the bottom of the map)
;; or
;; being hit by the missle
(define (end-game? s)
  (cond ((hit-bottom? (state-alien s)) #t)
        ((hit-alien? s) #t)
        (else #f)))

;; Alien -> Boolean
;; has to alien reached the bottom of the map
(define (hit-bottom? a)
  (>= (pos-y (alien-pos a))
      (- (image-height battleground)
         (image-height alien-image))))

;; WorldState -> Boolean
;; has the alien being hit by the missle
;; check if the position of the missle is
;; inside the alien image pixels (as a rectangle)
(define (hit-alien? s)
  (define missle-xy (missle-pos (state-missle s)))

  (define alien-xy (alien-pos (state-alien s)))
  (define alien-width (image-width alien-image))
  (define alien-height (image-height alien-image))
  (define alien-bottom (+ (pos-y alien-xy) (/ alien-height 2)))
  (define alien-top (- (pos-y alien-xy) (/ alien-height 2)))
  (define alien-right (+ (pos-x alien-xy) (/ alien-width 2)))
  (define alien-left (- (pos-x alien-xy) (/ alien-width 2)))

  (if (and (and (<= (pos-x missle-xy) alien-right)
                (>= (pos-x missle-xy) alien-left))
           (and (<= (pos-y missle-xy) alien-bottom)
                (>= (pos-y missle-xy) alien-top))) #t #f))

;; WorldState, Key -> WorldState
(define (handle-key-press s key)
  (cond ((key=? "left" key)
         (state (move-tank 'left (state-tank s))
                (state-alien s)
                (state-missle s)))
        ((key=? "right" key)
         (state (move-tank 'right (state-tank s))
                (state-alien s)
                (state-missle s)))
        ((key=? " " key)
         (state (state-tank s)
                (state-alien s)
                (fire-missle (state-tank s))))
        (else s)))


;; Tank -> Missle
;; launch missle from position relative
;; to the x position of the tank
(define (fire-missle t)
  (missle (pos (pos-x (tank-pos t))
               (- (pos-y (tank-pos t))
                  (/ (image-height tank-image) 2))) 1))

;; Symbol, Tank -> Tank
;; gets direction and tank and returns
;; new tank with changed position
;; if out of the map keeps the old position
(define (move-tank direction t)
  (define sign (cond ((eq? 'left direction) -)
                     ((eq? 'right direction) +)
                     (else
                      (error
                       "move-tank called with illegal direction"))))
  (define new-pos-x (sign (pos-x (tank-pos t)) (tank-step t)))
  (define valid-pos-x
    (if (out-of-bounds? (pos new-pos-x (pos-y (tank-pos t)))
                        (image-width tank-image)
                        (image-height tank-image))
        (pos-x (tank-pos t))
        new-pos-x))
  (tank (pos valid-pos-x
             (pos-y (tank-pos t)))
        (tank-step t)))

;; WorldState -> WorldState
(define (update s)
  (state (state-tank s)
         (update-alien (state-alien s))
         (update-missle (state-missle s))))

;; Alien -> Alien
;; move the alien at constant speed down
;; and with speed relative to game-difficulty sideways
;; pick sideways direction by using (random)
(define (update-alien a)
  (define sign (if (> (random) 0.49) - +))
  (define new-pos (pos (sign (pos-x (alien-pos a))
                             (+ game-difficulty (alien-step a)))
                       (+ (pos-y (alien-pos a))
                          (alien-step a))))
  (cond ((hit-bottom? a) a)
        (else (alien (if (out-of-bounds? new-pos
                                         (image-width alien-image)
                                         (image-height alien-image))
                         (alien-pos a)
                         new-pos)
                     (alien-step a)))))

;; Pos, Number, Number -> Boolean
;; takes position, width and height of game object
;; and checks it is in the bounds of the map
(define (out-of-bounds? xy w h)
  (or (> 0 (- (pos-x xy) (/ w 2))) ;; left
      (> 0 (- (pos-y xy) (/ h 2))) ;; top
      (< (image-height battleground)
         (+ (pos-x xy) (/ h 2)))   ;; bottom
      (< (image-width battleground)
         (+ (pos-y xy) (/ w 2))))) ;; right

;; Missle -> Missle
;; move the missle up with constant speed
(define (update-missle m)
  (missle (pos (pos-x (missle-pos m))
               (- (pos-y (missle-pos m))
                  (missle-step m)))
          (missle-step m)))

;; WorldState -> Image
(define (render s)
  (place-image missle-image
               (pos-x (missle-pos (state-missle s)))
               (pos-y (missle-pos (state-missle s)))
               (place-image alien-image
                            (pos-x (alien-pos (state-alien s)))
                            (pos-y (alien-pos (state-alien s)))
                            (place-image tank-image
                                         (pos-x (tank-pos
                                                 (state-tank s)))
                                         (pos-y (tank-pos
                                                 (state-tank s)))
                                         battleground))))

;; tests
(require rackunit rackunit/text-ui)

(define init-state (state tank1 alien1 missle1))
(define end-state (state tank1 (alien (pos 100 290) 1) missle1))

(define invasion-suite
  (test-suite
   "Testing the Alien Invasion game"

   (check-equal? (render init-state)
                 (bitmap "../images/battle-init-test.png"))

   ;; "end-game?"
   (check-true (end-game? end-state))
   (check-false (end-game? init-state))
   ;; "hit-bottom"
   (check-true (hit-bottom? (state-alien end-state)))
   (check-false (hit-bottom? (state-alien init-state)))

   ;; "move-tank"
   (check-equal? (pos-x (tank-pos (move-tank 'left tank1))) 90)
   (check-equal? (pos-x (tank-pos (move-tank 'right tank1))) 110)

   ;; "update-alien"
   (check-equal? (pos-y (alien-pos (update-alien alien1))) 11)
   ;; "update-missle"
   (check-equal? (pos-y (missle-pos (update-missle missle1))) 269)

   ;; direct hit from bottom
   (check-true (hit-alien? (state tank1
                                  (alien (pos 100 100) 1)
                                  (missle (pos 100 100) 1))))
   (check-true (hit-alien? (state tank1
                                  (alien (pos 100 100) 1)
                                  (missle (pos 100 93) 1))))
   (check-true (hit-alien? (state tank1
                                  (alien (pos 100 100) 1)
                                  (missle (pos 94 100) 1))))
   ;; just miss the bottom
   (check-false (hit-alien? (state tank1
                                   (alien (pos 100 100) 1)
                                   (missle (pos 100 92) 1))))
   ;; just miss the top
   (check-false (hit-alien? (state tank1
                                   (alien (pos 100 100) 1)
                                   (missle (pos 100 108) 1))))
   ;; just miss the left
   (check-false (hit-alien? (state tank1
                                   (alien (pos 100 100) 1)
                                   (missle (pos 88 100) 1))))
   ;; just miss right
   (check-false (hit-alien? (state tank1
                                  (alien (pos 100 100) 1)
                                  (missle (pos 112 100) 1))))

   (check-true (out-of-bounds? (pos 0 100) 22 14) "off left")
   (check-true (out-of-bounds? (pos 100 0) 22 14) "off top")
   (check-true (out-of-bounds? (pos 100 300) 22 14) "off bottom")
   (check-true (out-of-bounds? (pos 300 100) 22 14) "off right")
   (check-false (out-of-bounds? (pos 100 100) 22 14) "in")
   ))

(run-test invasion-suite)

;; The images created with racket image library:
(define tank-image (lambda ()
                     (define color "brown")
                     (define wheel (rectangle 5 15 "solid" color))
                     (define body (rectangle 10 10 "solid" color))
                     (define gun (rectangle 5 15 "solid" "brown"))
                     (overlay/xy gun -7 6 (beside wheel body wheel))))
(define alien-image (lambda ()
                      (define body (ellipse 22 10 "solid" "green"))
                      (define head (circle 5 "solid" "green"))
                      (overlay/xy head -6 4 body)))
(define missle-image (rectangle 3 7 "solid" "black"))
(place-image (alien-image) 50 50 (empty-scene 100 100))
(place-image (tank-image) 50 50 (empty-scene 100 100))
