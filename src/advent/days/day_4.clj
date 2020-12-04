(ns advent.days.day-4
  (:require [advent.util :as util]
            [clojure.string :as string]
            [clojure.string :as str]))

(def test-input "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd\nbyr:1937 iyr:2017 cid:147 hgt:183cm\n\niyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884\nhcl:#cfa07d byr:1929\n\nhcl:#ae17e1 iyr:2013\neyr:2024\necl:brn pid:760753108 byr:1931\nhgt:179cm\n\nhcl:#cfa07d eyr:2025 pid:166559648\niyr:2011 ecl:brn hgt:59in")

(def passport-rules
  {"byr" #(<= 1920 (util/parse-int %) 2002)
   "iyr" #(<= 2010 (util/parse-int %) 2020)
   "eyr" #(<= 2020 (util/parse-int %) 2030)
   "hgt" (fn [hgt]
           (let [[_ number unit] (re-find #"(\d+)(in|cm)" hgt)]
             (case unit
               "cm" (<= 150 (util/parse-int number) 193)
               "in" (<= 59 (util/parse-int number) 76)
               false)))
   "pid" #(not (nil? (re-find #"^\d{9}$" %)))
   "hcl" #(not (nil? (re-find #"^#[0-9a-f]{6}$" %)))
   "ecl" #(.contains ["amb" "blu" "brn" "gry" "grn" "hzl" "oth"] %)})


(defn passport-entry [p]
  (->>
    (re-seq #"(\w{3}):(\S+)" p)
    (map #(vec (rest %)))
    (into {})))

(defn is-valid? [p]
  (clojure.set/subset? (set (keys passport-rules)) (set (keys (passport-entry p)))))

(defn part-1 [passports]
  (count (filter is-valid? passports)))

(defn part-2 [passports]
  (count
    (filter (fn [passport]
              (when (is-valid? passport)
                (let [entry (passport-entry passport)]
                  (every? identity
                    (for [[key f] (seq passport-rules)] (f (get entry key)))))))
      passports)))


(defn run []
  (let [input (util/get-input 2020 4)
        entries (string/split input #"\n\n")]
    [(part-1 entries) (part-2 entries)]))