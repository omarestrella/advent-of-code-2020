(ns advent.days.day-1
  (:require [advent.util :as util]
            [clojure.string :as str]))

(defn part-1 [numbers]
  (->>
    numbers
    (filter (fn [num]
              (contains? numbers (- 2020 num))))
    (reduce *)))

(defn part-2 [numbers]
  (->>
    (for [x numbers y numbers z numbers] (vector x y z))
    (filter (fn [group]
              (= 2020 (reduce + group))))
    (first)
    (reduce *)))

(defn run []
  (let [input (util/get-input 2020 1)
        numbers (->>
                  (str/split-lines input)
                  (map util/parse-int)
                  (set))]
    [(part-1 numbers)
     (part-2 numbers)]))