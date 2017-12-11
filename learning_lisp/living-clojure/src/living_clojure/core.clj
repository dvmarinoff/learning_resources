(ns living-clojure.core)

;;;;
;; Living Clojure
;;;;

;; Simple values
1/3

2/2

10.0

(/ 2.0 2.0)

(/ 1 3.0)

"jam"

"jam and
butter"

:jam

\j

true

;; Collections
;; lists, vectors, maps and sets

;; lists
'(1 2 "jam" :marmalade-jam)

(first '(:rabbit :pocket-watch :marmalade :door))

(rest '(:rabbit :pocket-watch :marmalade :door))

(first (rest '(:rabbit :pocket-watch :marmalade :door)))

(first (rest (rest (rest (rest '(:rabbit :pocket-watch :marmalade :door))))))

(last '(:rabbit :pocket-watch :marmalade :door))

(cons 5 '())

(cons 5 nil)

(cons 1 (cons 2 (cons 3 (cons 4 nil))))

(list 1 2 3 4)

;; vectors for collecting data by index

[:jar1 1 2 3 :jar2]

(first [:jar1 1 2 3 :jar2])

(rest [:jar1 1 2 3 :jar2])

(nth [:jar1 1 2 3 :jar2] 3)

(last [:jar1 1 2 3 :jar2])

(count '(:rabbit :pocket-watch :marmalade :door))

;; conj adds to a collection in the most natural way for the data structure
(conj '(:jar2 :jar3) :jar1)

(conj [:jar1 :jar2] :jar3)

;; first, rest, last, count, conj are collection functions

;; maps for storing key-value pairs

{:jam1 "strawberry" :jam2 "blackberry"}

(get {:jam1 "strawberry" :jam2 "blackberry"} :jam1)

(get {:jam1 "strawberry" :jam2 "blackberry"} :jam3 "not found")

;; or more ideomatic(if you have keywords for keys)
(:jam1 {:jam1 "strawberry" :jam2 "blackberry"})

(keys {:jam1 "strawberry" :jam2 "blackberry"})

(vals {:jam1 "strawberry" :jam2 "blackberry"})

;; to 'update' a map (update, remove, merge)

(assoc {:jam1 "strawberry" :jam2 "blackberry"} :jam1 "blueberry")

(dissoc {:jam1 "strawberry" :jam2 "blackberry"} :jam2)

(merge {:jam1 "strawberry" :jam2 "blackberry"} {:jam1 "empty jar" :jam3 "blueberry"})

;; sets for unique collections of data

#{:red :green :blue}

(clojure.set/union #{:1 :2 :3} #{:2 :3 :4})

(clojure.set/difference #{:1 :2 :3} #{:2 :3 :4})

(clojure.set/intersection #{:1 :2 :3} #{:2 :3 :4})

(contains? #{:1 :2 :3 :4} :3)

(get #{:1 :2 :3 :4} :3)
(:3 #{:1 :2 :3 :4})
(#{:1 :2 :3 :4} :3)

(conj #{:red :green} :blue)

(disj #{:red :green :blue} :red)

;; code is data - all clojure code is made of lists of data

(first '(+ 1 3))

;; symbols and binding (or symbols as 'variables')

;; the binding is through a var
;; and scope is the whole namespace
(def developer "Alice")

;; use let for local scope and temporary bindings
;; what happens in a let stays in a let

(let [developer "Alice in Wonderland"] developer)
developer

;; functions

;; defn creates vars for functions
(defn follow-the-rabbit [] "Off we go!")
(follow-the-rabbit)

(defn shop-for-jams [jam1 jam2]
  {:name "jam basket"
   :jam1 jam1
   :jam2 jam2})

(shop-for-jams "strawberry" "marmalade")

;; anonymous functions
(fn [] (str "Off we go!"))
((fn [] (str "Off we go!")))
(#(str "Off we go!"))
(def follow-again (fn [] (str "Off we go!")))

;; anonymous shorthand with params
(#(str "Off we go!" " - " %) "again")

(#(str "Off we go!" " - " %1 %2) "again" "?")

;; organize your symbols in namespaces

(ns alice.favfoods)
*ns*
(def fav-food "strawberry jam")


(ns wonderland)
(require '[alice.favfoods :as af])

af/fav-food

(ns wonderland
  (:require [alice.favfoods :as af]))

af/fav-food

(ns wonderland
  (:require [alice.favfoods :refer :all]))

fav-food

;; Example:
(ns wonderland-fav-foods
  (:require [clojure.set :as s]))

(defn common-fav-foods [foods1 foods2]
  (let [food-set1 (set foods1)
        food-set2 (set foods2)
        common-foods (s/intersection food-set1 food-set2)]
    (str "Common foods are: " common-foods)))

(common-fav-foods [:jam :brownies :toast] [:jam :lettuce :carrots])

;; logic

(class true)

(true? true)
(nil? nil)

(not true)
(not false)
(not nil)
(= (not nil) (not false))

(not (= :drinkme 4))
(not= :drinkme 4)

;; logic tests for collections
(empty? [:table :door :key])
(seq [])

(defn is-empty [coll]
  (not (seq coll)))

(is-empty [])

;; collections and sequance abstractions
;; all implement the clojure.lang.IPersistantColection interface
;; collections support shared methods: count, conj, seq
;; sequances provide the shared functions: first, rest, cons
;; seq turn collection into a sequence

;; use seq to check for (not (empty? x))
(seq [])

;; check all elements
(every? odd? [1 3 5])

(every? #(> % 0) [1 3 5])

(defn drinkable [x]
  (= x :drinkme))

(not-any? drinkable [:poison :poison])

(some drinkable [:drinkme :poison])

;; controlling the flow

(if true "It is true" "It is false")
(if false "It is true" "it is false")

(if (drinkable :drinkme)
  "Try it"
  "Don't tyr it")

;; if you want to test something and also remember it use if-let
(if-let [need-to-grow-small (> 5 1)]
  "drink bottle"
  "don't drink bottle")

(when true "I only care if it is true")

(when-let [need-to-grow-small true] "drink bottle")

;; multi check form with default value
;; only first true expression gets evaluated (order is important)
;; nothing special about :else, may use anything that evaluates to true
(let [x 4]
  (cond
    (> x 10) "bigger than 10"
    (> x 5)  "bigger than 5"
    (> x 1)  "bigger than 1"
    :else "unknown"))

;; case is a shorthand form for cond where there is only one value
;; to be tested and it can be compared with an =
;; returns an error instead of nil for no mathing statement
(let [bottle "drinkme"]
  (case bottle
    "poison" "Don't touch"
    "drinkme" "Grow smaller"
    "empty" "all gone"))

(let [x 4]
  (case x
    1 "one"
    3 "two"
    4 "four"
    "unkown"))

;; partial application
(def adder (fn [x y] (+ x y)))
(def add-2 (partial adder 2))
(def add-1 (partial adder 1))

(adder 3 4)
(add-1 3)

(defn multiplier [x y] (* x y))
(multiplier 3 4)

;; comp for function composition
;; right to left <- f(g(x))

(defn add-1-and-double [x]
  ((comp (partial multiplier 2) add-1) x))

;; destructuring

(let [[color size] ["blue" "small"]]
  (str "The " color " door is " size))
