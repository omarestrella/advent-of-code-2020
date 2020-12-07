(ns advent.days.day-2
  (:require [advent.util :as util]
            [clojure.string :as str]))

(def matcher (partial re-find #"(\d+)-(\d+)\W(\w):\W(\w+)"))

(defn meets-old-policy? [password policy]
  (let [chars (str/split password #"")
        num-of-letters (count (filter #(= % (:letter policy)) chars))]
    (and
      (<= num-of-letters (:most policy))
      (>= num-of-letters (:least policy)))))

(defn meets-new-policy? [password policy]
  (let [chars (str/split password #"")
        letter (:letter policy)
        low-pos (- (:least policy) 1)
        high-pos (- (:most policy) 1)]
    (not=
      (= (nth chars low-pos) letter)
      (= (nth chars high-pos) letter))))

(defn part-1 [policies]
  (-> (filter (fn [policy-str]
                (let [[_ low high letter password] (matcher policy-str)]
                  (meets-old-policy? password {:letter letter
                                               :least (util/parse-int low)
                                               :most (util/parse-int high)})))
             policies)
    (count)))

(defn part-2 [policies]
  (-> (filter (fn [policy-str]
                (let [[_ low high letter password] (matcher policy-str)]
                  (meets-new-policy? password {:letter letter
                                               :least (util/parse-int low)
                                               :most (util/parse-int high)})))
        policies)
    (count)))

(defn run []
  (let [input (util/get-input 2020 2)
        lines (str/split-lines input)]
    [(part-1 lines) (part-2 lines)]))