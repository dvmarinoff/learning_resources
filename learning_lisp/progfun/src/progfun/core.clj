(ns progfun.core
  (:gen-class))

(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (println "Hello, World!"))

;; Week 1
;; Task 1 pascal triangle
(defn fact
  "find factorial of a number"
  [x]
  (if (= x 0)
    1
    (loop [n x a 1]
      (if (= n 1)
        a
        (recur (dec n) (* a n))))))
  
(defn is-pascal-position
  "is position row r col c in a pascal triangle"  
  [r c]
  (if (> c r)
    false
    true))

(defn calculate-pascal-value
  "calculate the value at row r and col c in a pascal triangle" 
  [r c]
  (/ (fact r) (* (fact c) (fact (- r c)))))

(defn find-in-pascal
  [r c]
  (if (is-pascal-position r c)
    (calculate-pascal-value r c)
    (println "not a valid pascal position")))

;; Task 2 Matching parens
(defn parens-value [p]
  (cond
    (= \( p) 1
    (= \) p) -1
    :else 0))

(defn sum-parens [p]
  (reduce + (map parens-value p)))

(defn balance
  "checks if parens in p are balanced"
  [p]
  (if (= 0 (sum-parens p))
   true 
   false))

;; Task 3
(defn count-change (money change)
  ())
