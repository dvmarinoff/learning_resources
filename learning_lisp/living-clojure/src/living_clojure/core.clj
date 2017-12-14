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

;; use :as to keep the original
(let [[color [size] :as original] ["blue" ["small"]]]
  {:color color :size size :original original})

;; destructuring maps
(let [{flower1 :flower1 flower2 :flower2}
      {:flower1 "red" :flower2 "blue"}]
  (str "The flowers are " flower1 " and " flower2))

;; use :or for default values
(let [{flower1 :flower1 flower2 :flower2 :or {flower2 "missing"}}
      {:flower1 "red"}]
  (str "The flowers are " flower1 " and " flower2))

;; shortcut for maps using :keys directive
(let [{:keys [flower1 flower2]}
      {:flower1 "red" :flower2 "blue"}]
  (str "The flowers are " flower1 " and " flower2))

;; example with defn
(defn flower-colors [{:keys [flower1 flower2]}]
  (str "The flowers are " flower1 " and " flower2))

;; the power of laziness over infinity

;; evaluate the first 5 members from the range [0, inf]
(take 5 (range))

;; repeat takes a value
(take 5 (repeat "rabbit"))

;; repeatedly takes a function (with no args) and executes it
(repeatedly 5 #(rand-int 100))

;; cycle takes a collection
(take 5 (cycle ["big" "small"]))

;; the other seq functions will also work on lazy sequences

;; recursion

;; first attempt
(defn n [xs]
  (let [x (first xs)]
    (when-not (nil? x)
      (do
        (prn x)
        (n (rest xs))))))

(n [1 2 3 4])

;; more concise
(defn alice-is [in out]
  (if (empty? in)
    out
    (alice-is (rest in) (conj out (str "Alice is " (first in))))))

(alice-is ["normal" "too small" "too big" "swimming"] [])

;; using loop and recur
;; loop repeats the body of the function inside
;; recur protects the stack (no tco)
(defn alice-is-2 [input]
  (loop [in input out []]
    (if (empty? in)
      out
      (recur (rest in) (conj out (str "Alice is " (first in)))))))

(alice-is-2 ["normal" "too small" "too big" "swimming"])

;; map the ultimate

(map #( str %) [:mouse :duck :dodo :lory :eaglet])

;; note that result is not a vector but a clojure.lang.LazySeq
;; so we can map on infinite sequences
(take 10 (map #(str %) (range)))

;; you can use map on multiple collections
;; it will terminate when the shortest collection ends
(defn gen-animal-string [animal color]
  (str color "-" animal))

(map gen-animal-string
     ["mouse" "duck" "dodo" "lory" "eaglet"]
     ["brown" "black" "blue" "pink" "gold"])

;; you can use it with infinite sequences

;; reduce the ultimate

(reduce + [1 2 3 4 5])

;; sum of squares
(reduce (fn [acc x] (+ acc (* x x))) [1 2 3])

;; won't work with infinite sequences

;; filter

(filter (complement nil?) [:mouse nil :duck :hourse nil])

;; complement takes a function and returns opposite truth value

;; remove
(remove nil? [:mouse nil :duck :hourse nil])

;; flatten
(flatten [[:duck [:mouse] [[:lory]]]])

;; partition
(partition 3 [1 2 3 4 5 6 7 8 9])

;; partition-all
;; won't drop the not fitting elements
(partition-all 3 [1 2 3 4 5 6 7 8 9 10])

;; partition-by
;; creates new partition every time the result changes
(partition-by #(= 3 %) [1 2 3 4 5 6 7 8 9 10])

;; into
;; use to transform into another collection
(into [] '(1 2 3 4))

(into (sorted-map) {:b 2 :d 4 :a 1})

;;;;
;; Handling Real-World State and Concurrency
;;;;

;; using atoms for independent items

(def who-atom (atom :caterpillar))

who-atom
;; => #atom[:caterpillar 0x621da3f9]

;; use @ to dereference the atom and see the value
@who-atom
;; => :caterpillar

;; reset! to change the state
(reset! who-atom :chrysalis)
@who-atom

;; swap! to change by appling a function (pure function)
(defn change [state]
  (case state
    :caterpillar :chrysalis
    :chysalis    :butterfly
    :butterfly))

(swap! who-atom change)

;; example
(def counter (atom 0))
@counter
(dotimes [_ 5] (swap! counter inc))
@counter

;; _ convetion for naming param that is not being used
;; in this case the name of the value

;; future form - takes a body and executes it another thread
(let [n 5]
  (future (dotimes [_ n] (swap! counter inc)))
  (future (dotimes [_ n] (swap! counter inc)))
  (future (dotimes [_ n] (swap! counter inc))))

@counter
;; => 15

;; using refs for coordinated changes
;; when you need to change multiple things like bank accounts
;; all actions on refs within the transaction are
;; - atomic
;; - consistent
;; - isolated
;; strategy like in databases (stm)

;; example
(def alice-height (ref 3))
(def right-hand-bites (ref 10))

;; dosync form - to run the function in a transaction
(defn eat-from-right-hand
  "decriments alice's height each time she eats from right hand"
  []
  (dosync (when (pos? @right-hand-bites)
    (alter right-hand-bites dec)
    (alter alice-height #(+ % 24)))))

(let [n 2]
  (future (dotimes [_ n] (eat-from-right-hand)))
  (future (dotimes [_ n] (eat-from-right-hand)))
  (future (dotimes [_ n] (eat-from-right-hand))))

(prn @right-hand-bites)
(prn @alice-height)

;; commute - alternative to alter, but does not do retries
;; may be useful in commutative transactions (addition) or
;; last-one-wins like behavior

;; using agents to manage changes on their own
;; asynchronous

(def who-agent (agent :caterpillar))
@who-agent

;; use send form to change the state of an agent
;; uses fixed thread pool
(send who-agent change)

;; use send-off form for potentialy I/O blocking actions
;; uses expandable thread pool

;; errors
(defn change-error [state]
  (throw (Exception. "Boom!")))

(send who-agent change-error)

;; evaluate to see the thrown error cached
(send-off who-agent change)

;; restart-agent resets and clears the agent from errors
;; else it stays in the same state
(restart-agent who-agent :caterpillar)

;; set-error-mode! - :fail or :continue
(set-error-mode! who-agent :continue)

;; set-error-handler!
(defn err-handler-fn [a e]
  (println "error " e " value is " @a))

(set-error-handler! who-agent err-handler-fn)

;;| Type  | Communication | Coordination  |
;;|-------+---------------+---------------|
;;| Atom  | Syncronous    | Uncoordinated |
;;| Ref   | Synchronous   | Coordinated   |
;;| Agent | Asynchronous  | Uncoordinated |
