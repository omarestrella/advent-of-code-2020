(ns advent.days.day-5
  (:require [advent.util :as util]
            [clojure.string :as str]))

(defn binary [c]
  (case c
    \B 1
    \F 0
    \R 1
    \L 0))


(defn boarding-pass [entry]
  (let [row (->> (take 7 entry) (map binary) (str/join ""))
        col (->> (take-last 3 entry) (map binary) (str/join ""))]
    {:row row
     :col col
     :row-val (Integer/parseInt row 2)
     :col-val (Integer/parseInt col 2)}))

(defn seats [input]
  (map (fn [entry]
         (let [bp (boarding-pass entry)]
           (+ (:col-val bp) (* 8 (:row-val bp))))) input))

(defn part-1 [s]
  (apply max s))

(defn part-2 [s]
  (let [sorted (sort s)
        all (range (first sorted) (last sorted))]
    (first (clojure.set/difference (set all) (set s)))))


(defn run []
  (let [input (str/split-lines (util/get-input 2020 5))
        seat-ids (seats input)]
    [(part-1 seat-ids) (part-2 seat-ids)]))