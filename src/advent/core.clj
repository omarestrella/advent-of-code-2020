(ns advent.core
  (:gen-class)
  (:require [advent.util :as util]
            [clojure.string :as str]))


(defn run-day-1 [numbers]
  (->>
    numbers
    (filter (fn [num]
              (contains? numbers (- 2020 num))))
    (reduce *)))

(defn run-day-2 [numbers]
  (->>
    (for [x numbers y numbers z numbers] (vector x y z))
    (filter (fn [group]
              (= 2020 (reduce + group))))
    (first)
    (reduce *)))

(defn -main [& args]
  (let [input (util/get-input 2020 1)
        numbers (->>
                  (str/split-lines input)
                  (map util/parse-int)
                  (set))]
    (println (run-day-1 numbers))
    (println (run-day-2 numbers))))