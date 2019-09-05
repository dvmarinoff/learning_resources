(ns living-clojure.perlin-noise
  (:require
   [quil.core :as q]))

;;;;
;; Noise vs Random
;;;;

;; Random
(defn draw-random []
  (q/background 0)
  (q/fill 255)
  (q/ellipse (q/map-range (q/random 100) 0 1 0 (q/width)) 240 24 24))

;; Noise
(def xoff (atom 0))

(defn draw-noise []
  (def x (q/map-range (q/noise @xoff) 0 1 0 (q/width)))
  (reset! xoff (+ @xoff 0.01))
  (q/background 0)
  (q/fill 255)
  (q/ellipse x 240 24 24))

(q/defsketch example
  :title ""
  ;; :draw draw-random
  :draw draw-noise
  :size [320 480])

;;;;
;; 1D Perlin Noise
;;;;

;; 2d movement
(def xoff1 (atom 0))
(def xoff2 (atom 10000))

(defn draw []
  (def x (q/map-range (q/noise @xoff1) 0 1 0 (q/width)))
  (def y (q/map-range (q/noise @xoff2) 0 1 0 (q/height)))
  (reset! xoff1 (+ @xoff1 0.01))
  (reset! xoff2 (+ @xoff2 0.01))
  (q/background 0)
  (q/fill 255)
  (q/ellipse x y 24 24))

(q/defsketch example
  :title ""
  :draw draw
  :size [320 480])

;; 1d terrain generation
(def xoff (atom 0))
(def start (atom 0))
(def step 0.01)

(defn draw []
  (q/background 51)
  (q/stroke 255)
  (q/no-fill)

  (q/begin-shape)
  (reset! xoff @start)
  (doseq [x (range 0 (q/width))]
    (do
      (q/stroke 255)
      (q/vertex x (* (q/height) (q/noise @xoff)))
      (reset! xoff (+ @xoff step))
      ))
  (q/end-shape)
  (reset! start (+ @start step))
  )

(q/defsketch example
  :title ""
  :draw draw
  :size [320 480])

;;;;
;; 2D Perlin Noise
;;;;

;; set individual pixels by x y pos with the set-pixel function
(defn draw []
  (let [img (q/create-image 320 320 :rgb)]
    (dotimes [x (q/width)]
      (dotimes [y (q/height)]
        (q/set-pixel img x y (q/color (* 2 x) (* 2 y) (+ x y)))))
    (q/set-image 0 0 img))
  (q/no-loop))

(def xoff (atom 0))
(def yoff (atom 0))
(def step 0.01)

;; set pixels directly in the 1d pixels int array
(defn draw []
  (let [px (q/pixels)]
    (dotimes [x (q/width)]
      (reset! xoff 0)
      (dotimes [y (q/height)]
        (let [r (* (q/noise @xoff @yoff) 255)
              index (+ x (* y 320))]

          (aset-int px index (q/color r r r))

          (swap! xoff #(+ step %))))
      (swap! yoff #(+ step %)))
    (q/update-pixels)
    (q/no-loop)))

(q/defsketch example
  :title ""
  :draw draw
  :size [320 480])

;;;;
;; Perlin Noise Flow Field
;;;;

(def xoff (atom 0))
(def yoff (atom 0))
(def step 0.1)
(def scale 20)
(declare rows)
(declare cols)

;; set pixels directly in the 1d pixels int array
(defn draw []
  (def cols (Math/floor (/ (q/width) scale)))
  (def rows (Math/floor (/ (q/height) scale)))
  (let [px (q/pixels)]
    (dotimes [x rows]
      (reset! xoff 0)
      (dotimes [y cols]
        (let [r (* (q/noise @xoff @yoff) 255)
              index (+ x (* y 320))
              v []]

          ;; (q/fill (q/color r r r))
          ;; (q/rect (* x scale) (* y scale) scale scale)

          (q/stroke 0)
          ;; (q/push-style)
          (q/push-matrix)
          (q/translate (* x scale) (* y scale))
          ;; (q/rotate (heading v))
          (q/rotate (q/radians v))
          (q/line 0 0 scale 0)
          (q/pop-matrix)
          ;; (q/pop-style)

          (swap! xoff #(+ step %))))
      (swap! yoff #(+ step %)))
    (q/no-loop)
    ))

(q/defsketch example
  :title ""
  :draw draw
  :size [320 480])



;;;;
;; OpenSimplex Noise
;;;;
