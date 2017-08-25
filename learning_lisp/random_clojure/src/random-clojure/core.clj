(ns random-clojure.core
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
  (if (zero? x)
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
  "checks if parens in char array p are balanced"
  [p]
  (if (zero? (sum-parens p))
   true
   false))

;; Task 3
(defn count-change (money change)
  ())


;;;; Fizz Buzz
(defn fizz-buzz
  ([i]
    (cond
      (zero? (mod i (* 3 5))) "FizzBuzz"
      (zero? (mod i 3)) "Fizz"
      (zero? (mod i 5)) "Buzz"
      :else (str i)))
  ([start end]
   (map fizz-buzz (range start end))))

(fizz-buzz 1)
(fizz-buzz 3)
(fizz-buzz 5)
(fizz-buzz 15)
(fizz-buzz 0 100)

;;;; digits
(defn digits [n]
  (reduce dr [] n))

(defn dr [acc i]
  (conj acc i))

(defn num->digits [num]
  (loop [n num res []]
    (if (zero? n)
      res
    (recur (quot n 10) (conj res (mod n 10))))))

(mod 9 10)

(num->digits 1024)

(digits 1024)

;;;; fibonacci
(defn fibo-iter
  ([n] (fibo-iter 0 1 n))
  ([curr nxt n]
   (cond
     (zero? n) curr
     :else (recur nxt (+ curr nxt) (dec n)))))
