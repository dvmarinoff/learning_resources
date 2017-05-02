(ns progfun.core-test
  (:require [clojure.test :refer :all]
            [progfun.core :refer :all]))

(deftest task-pascal
  (testing "fact"
    (is (= 1 (fact 0)))
    (is (= 1 (fact 1)))
    (is (= 24 (fact 4))))
  (testing "calculate-pascal-value"
    (is (= 6 (calculate-pascal-value 4 2)))
    (is (= 1 (calculate-pascal-value 0 0)))
    (is (= 1 (calculate-pascal-value 1 0)))
    (is (= 560 (calculate-pascal-value 16 3))))
  (testing "find-in-pascal"
    ;;(is (= "not a valid pascal position" (find-in-pascal 0 4)))
    (is (= 6 (find-in-pascal 4 2)))))
