(ns advent.days.day-6
  (:require [advent.util :as util]
            [clojure.string :as str]
            [clojure.set :refer [union intersection]]))

(defn part-1 [groups]
  (reduce
    (fn [val group]
      (+ val (count (apply union (map set (str/split-lines group))))))
    0
    groups))

(defn part-2 [groups]
  (reduce
    (fn [val group]
      (+ val (count (apply intersection (map set (str/split-lines group))))))
    0
    groups))

(defn run []
  (let [input (util/get-input 2020 6)
        groups (str/split input #"\n\n")]
    [(part-1 groups) (part-2 groups)]))