(ns living-clojure.l-systems
  (:require (quil.core :as q)))

(def axiom "A")
(def sentance axiom)
(def rules [{:a "A" :b "ABC"}
            {:a "B" :b "A"}])

(def axiom "F")
(def sentance axiom)
(def rules [{:a "F" :b "FF+[+F-F-F]-[-F+F+F]"}])

(def len (atom 100))

(defn str-first [s] (if (empty? s) "" (subs s 0 1)))
(str-first "")
(str-first "A")
(str-first "ABCD")

(defn str-rest [s] (if (empty? s) "" (subs s 1)))
(str-rest "")
(str-rest "A")
(str-rest "ABCD")

(defn match-rule [s]
  (first (filter #(= (str-first s) (:a %)) rules)))
(match-rule "")
(match-rule "A")
(match-rule "B")

(defn gen [xs]
  (let [rule (match-rule xs)]
    (cond (empty? xs) ""
          (not (empty? (match-rule xs))) (str (:b (match-rule xs))
                                              (gen (str-rest xs)))
          :else (str (str-first xs) (gen (str-rest xs))))))
(gen "A")
(gen "B")
(gen (gen "A"))
(gen (gen (gen "A")))
(gen "F")
(gen (gen (gen "F")))

(defn turtle [xs]
  (cond (empty? xs) (do (q/reset-matrix) nil)
        (= (str-first xs) "F") (do (q/line 0 0 0 (- 0 len))
                                   (q/translate 0 (- 0 len))
                                   (turtle (str-rest xs)))
        (= (str-first xs) "+") (do (q/rotate (/ 3.14 6))
                                   (turtle (str-rest xs)))
        (= (str-first xs) "-") (do (q/rotate (- 0 (/ 3.14 6)))
                                   (turtle (str-rest xs)))
        (= (str-first xs) "[") (do (q/push-style)
                                   (turtle (str-rest xs)))
        (= (str-first xs) "]") (do (q/pop-style)
                                   (turtle (str-rest xs)))
        ))

(defn draw []
  (q/no-loop)
  (q/fill 0)
  (q/translate 160 480)
  (turtle (gen (gen "F"))))

(q/defsketch example
  :title ""
  :draw draw
  :size [320 480])
