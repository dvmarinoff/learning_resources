(ns living-clojure.async-tea-party
  (:require [clojure.core.async :as async]))

;; creating a bufferd channel
;; puts will not block the thread until buffer is full
;;(def tea-channel (async/chan 10))

;; synchronous blocking put with >!! - puts data on the channel
;; synchronous blocking take with <!! - takes data from the channel
;;(async/>!! tea-channel :cup-of-tea)

;;(async/<!! tea-channel)

;; will close the channel, but data there is still accessible
;; when channek returns nil it is empty
;;(async/>!! tea-channel :cup-of-tea-1)
;;(async/>!! tea-channel :cup-of-tea-2)
;;(async/>!! tea-channel :cup-of-tea-4)

;;(async/<!! tea-channel)
;;(async/close! tea-channel)

;; async put with >!, needs a go block
;; async get with <!, needs a go block
;;(let [tea-channel (async/chan)]
;;  (async/go (async/>! tea-channel :cup-of-tea-1))
 ;; (async/go (println "Thanks for the " (async/<! tea-channel))))

;; you can use a background loop to continously wait for values
;;(def tea-channel (async/chan 10))

;;(async/go-loop []
;;  (println "Thanks for the " (async/<! tea-channel))
;;  (recur))

;;(async/>!! tea-channel :cup-of-tea-2)
;;(async/go (async/>! tea-channel :hot-cup-of-tea))

;; reading from multiple channels
(def tea-channel (async/chan 10))
(def milk-channel (async/chan 10))
(def sugar-channel (async/chan 10))

;; use alts! to get the value from the one that arrives first
(async/go-loop []
  (let [[v ch] (async/alts! [tea-channel milk-channel sugar-channel])]
    (println "Got " v " from " ch)
    (recur)))

(async/>!! sugar-channel :sugar)
(async/>!! milk-channel :milk)
(async/>!! tea-channel :tea)

;; go blocks are not bound to treads and are very lightweight processes
;; combined with the ability to wait for input across many channels

;; The async tea party project
(def google-tea-service-chan (async/chan 10))
(def yahoo-tea-service-chan (async/chan 10))
(def result-chan (async/chan 10))

;; use to simulate random wait time(sleep)
(defn random-add
  "picks up a random int [0, 100000] and sums up a vector filled with 1s of that random length"
  []
  (reduce + (conj [] (repeat 1 (rand-int 100000)))))

(defn request-google-tea-service []
  (async/go
    (random-add)
    (async/>! google-tea-service-chan "tea compliments of google")))

(defn request-yahoo-tea-service []
  (async/go
    (random-add)
    (async/>! yahoo-tea-service-chan "tea compliments of yahoo")))

(defn request-tea []
  (request-google-tea-service)
  (request-yahoo-tea-service)
  (async/go (let [[v] (async/alts!
                       [google-tea-service-chan
                        yahoo-tea-service-chan])]
              (async/>! result-chan v))))

(defn -main [& args]
  (println "Requesting tea!")
  (request-tea)
  (println (async/<!! result-chan)))
